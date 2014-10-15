//
//  Object+CategoryProperty.h
//  CategoryPropertyDemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "GCObject.h"

@interface GCObject (CategoryProperty)

@property (nonatomic, strong) NSArray* nonStrongArray;
@property (nonatomic, weak) NSArray* nonWeakArray;
@property (nonatomic, copy) NSArray* nonCopyArray;

@property (atomic, strong) NSArray* atomicStrongArray;
@property (atomic, weak) NSArray* atomicWeakArray;
@property (atomic, copy) NSArray* atomicCopyArray;

@end
