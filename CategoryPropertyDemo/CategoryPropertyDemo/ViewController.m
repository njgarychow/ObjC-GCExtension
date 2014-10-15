//
//  ViewController.m
//  CategoryPropertyDemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController.h"

#import "GCObject+CategoryProperty.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GCObject* obj = [[GCObject alloc] init];
    
    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.nonStrongArray = array;
        [array removeLastObject];
        //  will be @[@"1"]
    }
    
    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.nonCopyArray = array;
        [array removeLastObject];
        //  will be @[@"1", @"2"]
    }

    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.nonWeakArray = array;
        [array removeLastObject];
        //  will be nil
    }
    
    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.atomicStrongArray = array;
        [array removeLastObject];
        //  will be @[@"1"]
    }
    
    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.atomicCopyArray = array;
        [array removeLastObject];
        //  will be @[@"1", @"2"]
    }
    
    {
        NSMutableArray* array = [@[@"1", @"2"] mutableCopy];
        obj.atomicWeakArray = array;
        [array removeLastObject];
        //  will be nil
    }
    
    
    NSLog(@"non strong : %@", obj.nonStrongArray);
    NSLog(@"non copy : %@", obj.nonCopyArray);
    NSLog(@"non weak : %@", obj.nonWeakArray);
    NSLog(@"atomic strong : %@", obj.atomicStrongArray);
    NSLog(@"atomic copy : %@", obj.atomicCopyArray);
    NSLog(@"atomic weak : %@", obj.atomicWeakArray);
}



@end
