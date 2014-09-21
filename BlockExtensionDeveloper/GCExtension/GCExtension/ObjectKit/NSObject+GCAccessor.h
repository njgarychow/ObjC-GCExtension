//
//  NSObject+GCAccessor.h
//  GCExtension
//
//  Created by njgarychow on 9/21/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GCAccessor)

+ (void)extensionAccessorGenerator;

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames;
+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames;
+ (NSArray *)extensionAccessorNonatomicWeakPropertyNames;

+ (NSArray *)extensionAccessorAtomicStrongPropertyNames;
+ (NSArray *)extensionAccessorAtomicCopyPropertyNames;
+ (NSArray *)extensionAccessorAtomicWeakPropertyNames;

@end
