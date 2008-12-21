#import <Foundation/Foundation.h>
#include "SC3Controller.h"

int main (int argc, const char **argv) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    SC3Controller *controller = [[SC3Controller alloc] init];

    if(argv[1] == NULL) {
        printf("Usage:\nEnsure SC3Controller.sc is in SC class load path. Then\n\nsc3ctrl -x (executes code in environment variable SC_INTERPRET_TEXT)\nsc3ctrl -x A_DIFFERENT_VARIABLE_NAME\n\nOther usages: see README\n");
    } else {
        NSString *arg = [NSString stringWithUTF8String:argv[1]];
        
        if([arg isEqual:@"-x"]) {
            [controller interpretContentsOfEnvironmentVariable:(argv[2] == NULL ? "SC_INTERPRET_TEXT" : argv[2])];
            return 0;
        }
        
        if([arg isEqual:@"-d"]) {
            if(argc < 3) {
                printf("Usage: sc3ctrl -d classname\n");
            } else {
                [controller openHelpFile:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-j"]) {
            if(argc < 3) {
                printf("Usage: sc3ctrl -j classname\n");
            } else {
                [controller openClassFile:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-y"]) {
            if(argc < 3) {
                printf("Usage: sc3ctrl -y methodname\n");
            } else {
                [controller openImplementations:[NSString stringWithUTF8String:argv[2]]];
            }
        }
        
        if([arg isEqual:@"-Y"]) {
            if(argc < 3) {
                printf("Usage: sc3ctrl -Y methodname\n");
            } else {
                [controller openReferences:[NSString stringWithUTF8String:argv[2]]];
            }
        }    
        
        if([arg isEqual:@"-s"]) {
            [controller stop];
        }    
        
        if([arg isEqual:@"-c"]) {
            [controller clearPostWindow];
        }    
        
        if([arg isEqual:@"-p"]) {
            [controller postWindowToFront];
        }    
        
        if([arg isEqual:@"-k"]) {
            [controller recompile];
        }    
    }

    [controller close];
    [controller release];
    [pool drain];
    return 0;
}
