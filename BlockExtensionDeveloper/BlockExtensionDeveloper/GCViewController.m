//
//  GCViewController.m
//  BlockExtensionDeveloper
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCViewController.h"

#import "GCExtension.h"

@interface GCViewController ()

@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView* sv = [[UIScrollView alloc] initWithFrame:self.view.frame];
    sv.contentSize = CGSizeMake(CGRectGetWidth(sv.frame) * 2, CGRectGetHeight(sv.frame) * 3);
    sv.blockForDidScroll = ^(UIScrollView* sv) {
        NSLog(@"sv");
    };
    [sv usingDelegateBlock];
    [self.view addSubview:sv];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
