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
    
    UITableView* tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [tb registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    __weak typeof(tb) weaktb = tb;
    tb.blockForSectionNumber = ^ {
        return 2;
    };
    tb.blockForHeaderTitle = ^(int section) {
        return @"test";
    };
    tb.blockForHeaderHeight = ^(int section) {
        return 44.0f;
    };
    tb.blockForRowNumber = ^(int section) {
        return 10;
    };
    tb.blockForCellProvider = ^(NSIndexPath* indexPath) {
        UITableViewCell* cell = [weaktb dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
        return cell;
    };
    tb.blockForHeaderView = ^(int section) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        view.backgroundColor = [UIColor redColor];
        return view;
    };
    [self.view addSubview:tb];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
