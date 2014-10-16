//
//  ViewController.m
//  NotificationDemo
//
//  Created by njgarychow on 10/16/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController.h"

#import "GCExtension.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    [self addObserverForNotificationName:@"NotificationForTest" usingBlock:^(NSNotification *notification) {
        NSLog(@"for class method %@", notification);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserverForNotificationName:@"NotificationForTest" usingBlock:^(NSNotification *notification) {
        NSLog(@"for instance %@", notification);
    }];
    [[self class] addObserverForNotificationName:@"NotificationForTest" usingBlock:^(NSNotification *notification) {
        NSLog(@"for class %@", notification);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationForTest" object:nil];
}

//  This is not necessary
- (void)removeObserverNotification {
    [self removeObserverForNotificationName:@"NotificationForTest"];
    [[self class] removeObserverForNotificationName:@"NotificationForTest"];
}

- (void)dealloc {
    [self removeObserverNotification];
}

@end
