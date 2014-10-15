//
//  ViewController.m
//  TargetActionDemo
//
//  Created by njgarychow on 10/15/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController.h"

#import "GCExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //  for UIControl
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 44)];
    [button addControlEvents:UIControlEventTouchUpInside
                      action:^(UIControl *control, NSSet *touches) {
                          NSLog(@"%@ button touch up inside", control);
                      }];
    [self.view addSubview:button];
    
    UISwitch* sth = [[UISwitch alloc] initWithFrame:CGRectMake(0, 250, 44, 44)];
    [sth addControlEvents:UIControlEventValueChanged
                   action:^(UIControl *control, NSSet *touches) {
                       NSLog(@"%@ value changed", control);
                   }];
    [self.view addSubview:sth];
    
    
    
    
    //  for UIGestureRecognizer
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] init];
    [pan addActionBlock:^(UIGestureRecognizer *gesture) {
        NSLog(@"%@ gesture state: %ld", gesture, gesture.state);
    }];
    [self.view addGestureRecognizer:pan];
    
    //  for NSTimer
    __block int times = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES action:^(NSTimer *timer) {
        times++;
        NSLog(@"timer run times: %d", times);
        if (times == 10) {
            [timer invalidate];
            NSLog(@"timer stoped");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
