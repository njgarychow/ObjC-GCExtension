//
//  GCMacro.h
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#ifndef GCExtension_GCMacro_h
#define GCExtension_GCMacro_h


#define GCBlockInvoke(block, ...)               do {                            \
                                                    if (block) {                \
                                                        block(__VA_ARGS__);    \
                                                    }                           \
                                                } while(0)

#define GCRetain(object)                do {            \
                                            CFTypeRef retainTarget = (__bridge CFTypeRef)(object);    \
                                            CFRetain(retainTarget);             \
                                        } while(0)
#define GCRelease(object)               do {            \
                                            CFTypeRef releaseTarget = (__bridge CFTypeRef)(object);       \
                                            CFRelease(releaseTarget);            \
                                        } while(0)



#endif
