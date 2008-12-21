//
//  SC3Controller.m
//  sc3ctrl
//
//  Created by Robin Watson on 21/December/2008.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SC3Controller.h"

@implementation SC3Controller

- (id)init
{
    [super init];
    manager = [[OSCManager alloc] init];
    [manager setDelegate:self];
    outport = [manager createNewOutputToAddress:@"127.0.0.1" atPort:57120];
    return self;
}


- (void)interpretContentsOfEnvironmentVariable:(const char *)var
{
    char *utf8cmd = getenv(var);
    
    if(utf8cmd == NULL) {
        Log(@"$%s is NULL", var);
        
        return;
    }
    
    NSString *cmd = [NSString stringWithUTF8String:utf8cmd];

    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/cmd"];
    [msg addString:cmd];
    
    Log(@"Sending cmd %@", cmd);
    
    [outport sendThisMessage:msg];
}


- (void)openHelpFile:(NSString *)classname
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/help"];
    [msg addString:classname];
    
    Log(@"Opening helpfile %@", classname);
    
    [outport sendThisMessage:msg];
}


- (void)openClassFile:(NSString *)classname
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/class"];
    [msg addString:classname];
    
    Log(@"Opening classfile %@", classname);
    
    [outport sendThisMessage:msg];
}


- (void)openImplementations:(NSString *)method
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/implementations"];
    [msg addString:method];
    
    Log(@"Opening implementations of %@", method);
    
    [outport sendThisMessage:msg];
}


- (void)openReferences:(NSString *)method
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/references"];
    [msg addString:method];
    
    Log(@"Opening references to %@", method);
    
    [outport sendThisMessage:msg];
}

- (void)stop
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/stop"];
    
    Log(@"Stopping server");
    [outport sendThisMessage:msg];
}

- (void)clearPostWindow
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/clear"];
    
    Log(@"Clearing post window");
    [outport sendThisMessage:msg];    
}

- (void)postWindowToFront
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/postfront"];
    
    Log(@"Post window to front");
    [outport sendThisMessage:msg];        
}

- (void)recompile
{
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/recompile"];
    
    Log(@"Recompiling");
    [outport sendThisMessage:msg];        
}

- (void)close
{
    [manager release];
}

@end
