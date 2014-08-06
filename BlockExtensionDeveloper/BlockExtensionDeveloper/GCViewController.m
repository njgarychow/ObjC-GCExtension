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
    
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [button addControlEvents:UIControlEventTouchUpInside
                      action:^(UIControl *control, NSSet *touches) {
                          NSLog(@"touch up inside %@ %@", control, touches);
                      }];
    [button removeAllControlEventsAction:UIControlEventTouchUpInside];
    
    [button sendActionsForControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
//
//    UIGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^{
//        NSLog(@"tesfd");
//    }];
//    [self.view addGestureRecognizer:tap];
//    
//    UITableView* ta = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    ta.rowNumberBlock = ^(int section) {
//        return 4;
//    };
//    ta.rowHeightBlock = ^(NSIndexPath* indexPath) {
//        return 100.0f;
//    };
//    ta.cellProviderBlock = ^(NSIndexPath* indexPath) {
//        UITableViewCell* cell = [[UITableViewCell alloc] init];
//        return cell;
//    };
//    [self.view addSubview:ta];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)_tap1:(id)sender {
    NSLog(@"tap1 %@", sender);
}
- (void)_tap2:(id)sender {
    NSLog(@"tap2 %@", sender);
}

@end
