#import <Foundation/Foundation.h>
#import <VVOSC/VVOSC.h>


void interpretContentsOfEnvironmentVariable(const char *var) {
    char *utf8cmd = getenv(var);
    
    if(utf8cmd == NULL) {
        NSLog(@"$%s is NULL", var);
        return;
    }
    
    NSString *cmd = [NSString stringWithUTF8String:utf8cmd];
    OSCManager *manager = [[OSCManager alloc] init];
    
    OSCOutPort *outport = [manager createNewOutputToAddress:@"127.0.0.1" atPort:57120];
    OSCMessage *msg = [OSCMessage createMessageToAddress:@"/sc3ctrl/cmd"];
    [msg addString:cmd];
    
    NSLog(@"Sending cmd %@", cmd);
    
    [outport sendThisMessage:msg];
    [manager release];
}

int main (int argc, const char **argv) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    if(argv[1] == NULL) {
        NSLog(@"Usage: sc3ctrl -x");
    } else {
        NSString *arg = [NSString stringWithUTF8String:argv[1]];
        
        if([arg isEqual:@"-x"]) {
            if(argv[2] == NULL) {
                interpretContentsOfEnvironmentVariable("SC3_INTERPRET_TEXT");
            } else {
                interpretContentsOfEnvironmentVariable((const char *)argv[2]);
            }
        }
    }
    
    [pool drain];
    return 0;
}
