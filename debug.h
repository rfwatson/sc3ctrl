/*
 *  debug.h
 *  sc3ctrl
 *
 *  Created by Robin Watson on 21/December/2008.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#if Debug_Enabled
#define Log( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define Log( s, ... ) 
#endif



