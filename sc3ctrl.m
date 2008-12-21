#import <Foundation/Foundation.h>
#include "SC3Controller.h"

int main (int argc, const char **argv) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    SC3Controller *controller = [[SC3Controller alloc] init];

    if(argv[1] == NULL) {
        NSLog(@"Usage: sc3ctrl -x");
    } else {
        NSString *arg = [NSString stringWithUTF8String:argv[1]];
        
        if([arg isEqual:@"-x"]) {
            [controller interpretContentsOfEnvironmentVariable:(argv[2] == NULL ? "SC3_INTERPRET_TEXT" : argv[2])];
            return 0;
        }
        
        if([arg isEqual:@"-d"]) {
            if(argc < 3) {
                NSLog(@"Usage: sc3ctrl -d classname");
            } else {
                [controller openHelpFile:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-j"]) {
            if(argc < 3) {
                NSLog(@"Usage: sc3ctrl -j classname");
            } else {
                [controller openClassFile:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-y"]) {
            if(argc < 3) {
                NSLog(@"Usage: sc3ctrl -y methodname");
            } else {
                [controller openImplementations:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-Y"]) {
            if(argc < 3) {
                NSLog(@"Usage: sc3ctrl -Y methodname");
            } else {
                [controller openReferences:[NSString stringWithUTF8String:argv[2]]];
            }
        }        
    }

    [controller close];
    [controller release];
    [pool drain];
    return 0;
}
