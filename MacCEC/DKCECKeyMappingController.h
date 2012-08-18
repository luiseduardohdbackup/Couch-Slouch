//
//  DKCECKeyMapping.h
//  MacCEC
//
//  Created by Daniel Kennett on 18/08/2012.
//  Copyright (c) 2012 Daniel Kennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cectypes.h"
#import "DKLocalAction.h" 

@class DKCECKeyMapping;

@interface DKCECKeyMappingController : NSObject

+(DKCECKeyMappingController *)sharedController;

@property (nonatomic, readonly, strong) DKCECKeyMapping *baseMapping;

-(DKCECKeyMapping *)keyMappingForApplicationWithIdentifier:(NSString *)appIdentifier;
-(DKCECKeyMapping *)duplicateMapping:(DKCECKeyMapping *)mapping withNewApplicationIdentifier:(NSString *)appIdentifier;

@end

@interface DKCECKeyMapping : NSObject <NSCopying>

-(id <DKLocalAction>)actionForKeyPress:(cec_keypress)keypress;

-(id)initWithPropertyListRepresentation:(NSDictionary *)plist;
-(NSDictionary *)propertyListRepresentation;

-(void)addAction:(id <DKLocalAction>)action;
-(void)removeAction:(id <DKLocalAction>)action;
-(void)addActions:(NSArray *)actions;
-(void)removeActions:(NSArray *)actions;

@property (nonatomic, readwrite, copy) NSString *applicationIdentifier;
@property (nonatomic, readonly, copy) NSString *lastKnownName;
@property (nonatomic, readonly, copy) NSArray *actions;

@end