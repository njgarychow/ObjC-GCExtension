//
//  TableViewModel.m
//  MVVMDemo
//
//  Created by njgarychow on 10/16/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import "TableViewModel.h"

#import "GCExtension.h"

@implementation TableViewModel

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        
        [self setupBlocks];
    }
    return self;
}

- (void)setupBlocks {
    static NSString* reuseIdentifier = @"reuseIdentifier";
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    __weak typeof(self) weakSelf = self;
    self.blockForRowNumber = ^(UITableView* tb, int section) {
        return (int)[weakSelf.data count];
    };
    self.blockForRowHeight = ^(UITableView* tb, NSIndexPath* path) {
        return (float)(arc4random() % 100 + 50);
    };
    self.blockForRowCell = ^(UITableView* tb, NSIndexPath* path) {
        UITableViewCell* cell = [weakSelf dequeueReusableCellWithIdentifier:reuseIdentifier
                                                               forIndexPath:path];
        cell.textLabel.text = weakSelf.data[path.row];
        return cell;
    };
}

@end
