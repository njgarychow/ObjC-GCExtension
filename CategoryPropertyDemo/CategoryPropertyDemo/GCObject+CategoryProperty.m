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

+ (void)load {
    [self extensionAccessorGenerator];
}

@dynamic nonStrongArray;
@dynamic nonCopyArray;
@dynamic nonWeakArray;
@dynamic atomicStrongArray;
@dynamic atomicCopyArray;
@dynamic atomicWeakArray;

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames {
    return @[@"nonStrongArray"];
}
+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"nonCopyArray"];
}
+ (NSArray *)extensionAccessorNonatomicWeakPropertyNames {
    return @[@"nonWeakArray"];
}
+ (NSArray *)extensionAccessorAtomicStrongPropertyNames {
    return @[@"atomicStrongArray"];
}
+ (NSArray *)extensionAccessorAtomicCopyPropertyNames {
    return @[@"atomicCopyArray"];
}
+ (NSArray *)extensionAccessorAtomicWeakPropertyNames {
    return @[@"atomicWeakArray"];
}

@end
