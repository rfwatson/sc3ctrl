//
//  OSCOutPort.h
//  OSC
//
//  Created by bagheera on 9/20/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#if IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif


#include <arpa/inet.h>

#import "OSCPacket.h"
#import "OSCBundle.h"
#import "OSCMessage.h"




@interface OSCOutPort : NSObject {
	BOOL					deleted;
	int						sock;
	struct sockaddr_in		addr;
	int                     port;
	NSString				*addressString;
	NSString				*portLabel;	//	used it to distinguish between multiple osc outputs
}

+ (id) createWithAddress:(NSString *)a andPort:(int)p;
+ (id) createWithAddress:(NSString *)a andPort:(int)p labelled:(NSString *)l;
- (id) initWithAddress:(NSString *)a andPort:(int)p;
- (id) initWithAddress:(NSString *)a andPort:(int)p labelled:(NSString *)l;
- (void) prepareToBeDeleted;

- (NSDictionary *) createSnapshot;

- (BOOL) createSocket;

- (void) sendThisBundle:(OSCBundle *)b;
- (void) sendThisMessage:(OSCMessage *)m;
- (void) sendThisPacket:(OSCPacket *)p;

- (void) setAddressString:(NSString *)n;
- (void) setPort:(int)p;
- (void) setAddressString:(NSString *)n andPort:(int)p;

- (NSString *) portLabel;
- (void) setPortLabel:(NSString *)n;

- (int) port;
- (NSString *) addressString;

@end
