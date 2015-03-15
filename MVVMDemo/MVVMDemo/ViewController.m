//
//  ViewController.m
//  MVVMDemo
//
//  Created by njgarychow on 10/16/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "ViewController.h"

#import "TableViewModel.h"
#import "GCExtension.h"

#import "ViewController2.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    
    //  use a array as data sources. you do not need to define dataSources as a property.
    //  less properties, less bugs.
    NSArray* dataSources = @[@"item1", @"item2", @"item3", @"item4", @"item5", @"item6", @"item7"];
    
    __weak typeof(self) weakSelf = self;
    TableViewModel* viewModel = ({
        TableViewModel* tableView = [[TableViewModel alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                                    style:UITableViewStylePlain];
        tableView.data = dataSources;
        //  seperate blocks into 2 files. less code in ViewController.
        [tableView withBlockForRowDidSelect:^(UITableView *view, NSIndexPath *path) {
            NSString* item = dataSources[path.row];
            
            ViewController2* vc2 = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
            vc2.item = item;
            vc2.dismissActionBlock = ^(NSDictionary* userInfo) {
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            };
            [weakSelf presentViewController:vc2 animated:YES completion:nil];
        }];
        tableView;
    });
    [self.view addSubview:viewModel];
}

@end
