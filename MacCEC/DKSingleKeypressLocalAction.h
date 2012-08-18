//
//  DKSingleKeypressLocalAction.h
//  MacCEC
//
//  Created by Daniel Kennett on 18/08/2012.
//  Copyright (c) 2012 Daniel Kennett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DKLocalAction.h"
#import "cectypes.h"

@interface DKSingleKeypressLocalAction : NSObject <DKLocalAction>

-(id)initWithLocalKeyCode:(CGKeyCode)keyCode forDeviceKeyCode:(cec_user_control_code)deviceCode;

@property (nonatomic, readonly) cec_user_control_code deviceKeyCode;
@property (nonatomic, readonly) CGKeyCode localKeyCode;

@end
