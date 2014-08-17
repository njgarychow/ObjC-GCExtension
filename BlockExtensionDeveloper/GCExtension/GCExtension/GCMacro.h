//
//  GCMacro.h
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#ifndef GCExtension_GCMacro_h
#define GCExtension_GCMacro_h


#define GCBlockInvoke(block)            do {                            \
                                            if (block) {                \
                                                block();    \
                                            }                           \
                                        } while(0)


#define GCBlockInvoke1(block, p1)       do {                            \
                                            if (block) {                \
                                                block();    \
                                            }                           \
                                        } while(0)



#endif
