//
//  ViewController2.m
//  MVVMDemo
//
//  Created by njgarychow on 10/16/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController2.h"
#import "GCExtension.h"

@interface ViewController2 ()

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemLabel.text = self.item;
    
    __weak typeof(self) weakSelf = self;
    [self.dismissButton addControlEvents:UIControlEventTouchUpInside
                                  action:^(UIControl *control, NSSet *touches) {
                                      GCBlockInvoke(weakSelf.dismissActionBlock, nil);
                                  }];
}

@end
