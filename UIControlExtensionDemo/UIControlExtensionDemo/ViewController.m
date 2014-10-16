//
//  ViewController.m
//  UIControlExtensionDemo
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
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 150, 200, 44)];
    btn.backgroundColor = [UIColor redColor];
    [btn addControlEvents:UIControlEventTouchUpInside
                   action:^(UIControl *control, NSSet *touches) {
                       NSLog(@"%@ touch up inside", control);
                   }];
    [self.view addSubview:btn];
    
    UISwitch* sth = [[UISwitch alloc] initWithFrame:CGRectMake(100, 200, 44, 44)];
    [sth addControlEvents:UIControlEventValueChanged
                   action:^(UIControl *control, NSSet *touches) {
                       NSLog(@"%@ value changed", control);
                   }];
    [self.view addSubview:sth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
