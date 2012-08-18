//
//  DKCECKeyMapping.m
//  MacCEC
//
//  Created by Daniel Kennett on 18/08/2012.
//  Copyright (c) 2012 Daniel Kennett. All rights reserved.
//

#import "DKCECKeyMappingController.h"

static NSString * const kBaseMappingUserDefaultsKey = @"BaseMapping";
static NSString * const kAppMappingsUserDefaultsKey = @"ApplicationMappings";

@interface DKCECKeyMappingController ()

@property (nonatomic, readwrite, strong) NSMutableDictionary *mappingStorage;
@property (nonatomic, readwrite, strong) DKCECKeyMapping *baseMapping;

@end

@implementation DKCECKeyMappingController

static DKCECKeyMappingController *sharedController;

+(DKCECKeyMappingController *)sharedController {
	if (sharedController != nil)
		sharedController = [DKCECKeyMappingController new];
	return sharedController;
}

-(id)init {
	self = [super init];
	if (self) {

		self.mappingStorage = [NSMutableDictionary new];

		// TODO: Default mappings
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSDictionary *base = [defaults valueForKey:kBaseMappingUserDefaultsKey];
		self.baseMapping = [[DKCECKeyMapping alloc] initWithPropertyListRepresentation:base];

		NSArray *appMappings = [defaults valueForKey:kAppMappingsUserDefaultsKey];
		for (NSDictionary *dict in appMappings) {
			DKCECKeyMapping *mapping = [[DKCECKeyMapping alloc] initWithPropertyListRepresentation:dict];
			if (mapping)
				[self.mappingStorage setValue:mapping forKey:mapping.applicationIdentifier];
		}

		[self saveMappings];
	}
	return self;
}

-(void)dealloc {
	[self saveMappings];
}

-(DKCECKeyMapping *)keyMappingForApplicationWithIdentifier:(NSString *)appIdentifier {
	return [self.mappingStorage valueForKey:appIdentifier];
}

-(DKCECKeyMapping *)duplicateMapping:(DKCECKeyMapping *)mapping withNewApplicationIdentifier:(NSString *)appIdentifier {
	if (appIdentifier.length == 0) return nil;
	DKCECKeyMapping *newMapping = [mapping copy];
	newMapping.applicationIdentifier = appIdentifier;
	[self.mappingStorage setValue:newMapping forKey:appIdentifier];
	[self performSelector:@selector(saveMappings) withObject:nil afterDelay:5.0];
	return newMapping;
}

-(void)saveMappings {

	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setValue:[self.baseMapping propertyListRepresentation] forKey:kBaseMappingUserDefaultsKey];

	NSMutableArray *mappings = [NSMutableArray new];

	for (NSString *key in [self.mappingStorage allKeys]) {
		DKCECKeyMapping *mapping = [self.mappingStorage valueForKey:key];
		[mappings addObject:[mapping propertyListRepresentation]];
	}

	[defaults setValue:mappings forKey:kAppMappingsUserDefaultsKey];
	[defaults synchronize];
}

@end

static NSString * const kKeyMappingApplicationIdentifierKey = @"identifier";
static NSString * const kKeyMappingLastKnownNameKey = @"name";
static NSString * const kKeyMappingActionsKey = @"actions";
static NSString * const kLocalActionClassKey = @"class";

@interface DKCECKeyMapping ()

@property (nonatomic, readwrite, copy) NSString *lastKnownName;
@property (nonatomic, readwrite, copy) NSArray *actions;

@end

@implementation DKCECKeyMapping

-(id)init {
	return [self initWithPropertyListRepresentation:nil];
}

-(id)initWithPropertyListRepresentation:(NSDictionary *)plist {

	self = [super init];
	if (self) {

		[self addObserver:self forKeyPath:@"applicationIdentifier" options:0 context:nil];

		self.lastKnownName = [plist valueForKey:kKeyMappingLastKnownNameKey];
		self.applicationIdentifier = [plist valueForKey:kKeyMappingApplicationIdentifierKey];

		NSArray *actionRepresentations = [plist valueForKey:kKeyMappingActionsKey];
		NSMutableArray *mutableActions = [NSMutableArray arrayWithCapacity:actionRepresentations.count];

		for (NSDictionary *dict in actionRepresentations) {

			NSString *className = [dict valueForKey:kLocalActionClassKey];
			Class actionClass = NSClassFromString(className);

			if (actionClass != nil) {

				id action = [actionClass alloc];
				if ([action conformsToProtocol:@protocol(DKLocalAction)]) {
					action = [(id <DKLocalAction>)action initWithPropertyListRepresentation:dict];
					if (action)
						[mutableActions addObject:action];
				}
			}
		}
		self.actions = [NSArray arrayWithArray:mutableActions];
	}

	return self;
}

-(id)copyWithZone:(NSZone *)zone {
	return [[DKCECKeyMapping alloc] initWithPropertyListRepresentation:[self propertyListRepresentation]];
}

-(void)dealloc {
	[self removeObserver:self forKeyPath:@"applicationIdentifier"];
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"applicationIdentifier"]) {

		NSString *appPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:self.applicationIdentifier];
		if (appPath.length == 0) return;
		NSBundle *appBundle = [[NSBundle alloc] initWithPath:appPath];
		NSString *bundleName = [[appBundle infoDictionary] valueForKey:(__bridge NSString *)kCFBundleNameKey];
		if (bundleName.length > 0)
			self.lastKnownName = bundleName;

    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(NSDictionary *)propertyListRepresentation {

	NSMutableDictionary *plist = [NSMutableDictionary new];
	[plist setValue:self.applicationIdentifier forKey:kKeyMappingApplicationIdentifierKey];
	[plist setValue:self.lastKnownName forKey:kKeyMappingLastKnownNameKey];

	NSArray *actionReps = [self.actions valueForKey:@"propertyListRepresentation"];
	[plist setValue:actionReps forKey:kKeyMappingActionsKey];

	return plist;
}

-(id <DKLocalAction>)actionForKeyPress:(cec_keypress)keypress {

	for (id <DKLocalAction> potentialAction in self.actions) {
		if ([potentialAction matchesKeyPress:keypress])
			return potentialAction;
	}
	return nil;
}

-(void)addAction:(id <DKLocalAction>)action {
	if (action) [self addActions:@[action]];
}

-(void)removeAction:(id <DKLocalAction>)action {
	if (action) [self removeActions:@[action]];
}

-(void)addActions:(NSArray *)actions {
	self.actions = [self.actions arrayByAddingObjectsFromArray:actions];
}

-(void)removeActions:(NSArray *)actions {
	NSMutableArray *mutableActions = [self.actions mutableCopy];
	[mutableActions removeObjectsInArray:actions];
	self.actions = [NSArray arrayWithArray:mutableActions];
}

@end
