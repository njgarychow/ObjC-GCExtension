//
//  Object+CategoryProperty.m
//  CategoryPropertyDemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "GCObject+CategoryProperty.h"

#import "GCExtension.h"

@implementation GCObject (CategoryProperty)

@dynamic nonStrongArray;
@dynamic nonCopyArray;
@dynamic nonWeakArray;
@dynamic atomicStrongArray;
@dynamic atomicCopyArray;
@dynamic atomicWeakArray;

+ (void)load {
    [self extensionAccessorGenerator];
}

@end
