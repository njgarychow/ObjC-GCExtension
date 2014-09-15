//
//  NSObject+GCKVO.h
//  GCExtension
//
//  Created by njgarychow on 9/16/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GCKVOBlock)(NSDictionary* change);

@interface NSObject (GCKVO)

- (void)startObserveObject:(NSObject *)observeTarger
                forKeyPath:(NSString *)keyPath
                usingBlock:(GCKVOBlock)handler;
- (void)startObserveObject:(NSObject *)observeTarger
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                usingBlock:(GCKVOBlock)handler;

- (void)stopObserveObject:(NSObject *)observeTarger
               forKeyPath:(NSString *)keyPath;

@end
