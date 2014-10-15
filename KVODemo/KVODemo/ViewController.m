//
//  ViewController.m
//  KVODemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController.h"

#import "GCExtension.h"
#import "GCObserve.h"

@interface ViewController ()

@property (nonatomic, strong) NSObject* kvoObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GCObserve* observe = [[GCObserve alloc] init];
    
    // This observe will crash.
//    [observe addObserver:self forKeyPath:@"observe" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

    
    [self startObserveObject:observe forKeyPath:@"observe" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        
        NSLog(@"target: %@", target);
        NSLog(@"keyPath : %@", keyPath);
        NSLog(@"change: %@", change);
    }];
    // trigger the observe method or block
    observe.observe = @"teasdf";
    
    
    //  It will leak.
    [self addObserver:observe forKeyPath:@"kvoObject" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    __weak typeof(observe) weak_observe = observe;
    [observe startObserveObject:self forKeyPath:@"kvoObject" usingBlock:^(NSObject *target, NSString *keyPath, NSDictionary *change) {
        
        weak_observe.observe = @"test";
    }];
    
    self.kvoObject = [[NSObject alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.kvoObject = [[NSObject alloc] init];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSLog(@"ViewContoller");
    NSLog(@"object: %@", object);
    NSLog(@"keyPath : %@", keyPath);
    NSLog(@"change : %@", change);
}

@end
