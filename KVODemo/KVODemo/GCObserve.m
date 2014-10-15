//
//  GCObserve.m
//  KVODemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "GCObserve.h"

@implementation GCObserve

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"GCObserve");
    NSLog(@"object: %@", object);
    NSLog(@"keyPath : %@", keyPath);
    NSLog(@"change : %@", change);
}

- (void)dealloc {
    NSLog(@"GCObserve dealloc");
}

@end
