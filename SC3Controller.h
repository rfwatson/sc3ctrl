//
//  SC3Controller.h
//  sc3ctrl
//
//  Created by Robin Watson on 21/December/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <VVOSC/VVOSC.h>
#include "debug.h"

@interface SC3Controller : NSObject {
    OSCManager *manager;
    OSCOutPort *outport;
}

- (void)interpretContentsOfEnvironmentVariable:(const char *)var;
- (void)openHelpFile:(NSString *)classname;
- (void)openClassFile:(NSString *)classname;
- (void)openImplementations:(NSString *)method;
- (void)openReferences:(NSString *)method;
- (void)stop;
- (void)clearPostWindow;
- (void)postWindowToFront;
- (void)recompile;
- (void)close;

@end
