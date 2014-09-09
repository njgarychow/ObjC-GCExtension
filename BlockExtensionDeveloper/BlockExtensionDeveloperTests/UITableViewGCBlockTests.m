//
//  UITableViewGCBlockTests.m
//  BlockExtensionDeveloper
//
//  Created by njgarychow on 14-8-8.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "Kiwi.h"

#import "UITableView+GCBlock.h"


SPEC_BEGIN(UITableView_GCBlock_Tests)


describe(@"UITableView Block", ^{
    
    context(@"when only necessary blocks -> blockForRowNumber, blockForCellProvider", ^{
        
        let(window, ^id{
            return [[[UIApplication sharedApplication] delegate] window];
        });
        
        let(tableview, ^id{
            UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 10000)];
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
            return tableView;
        });
        
        int const rowCount = 10;
        
        beforeEach(^{
            [window addSubview:tableview];
            
            __weak typeof(tableview) weakTableview = tableview;
            [tableview setBlockForRowNumber:^int(int section) {
                return rowCount;
            }];
            [tableview setBlockForCellProvider:^UITableViewCell *(NSIndexPath* indexPath) {
                UITableViewCell* cell = [weakTableview
                                         dequeueReusableCellWithIdentifier:@"reuse"
                                         forIndexPath:indexPath];
                cell.tag = indexPath.row;
                return cell;
            }];
            [tableview usingBlocks];
            [tableview reloadData];
        });
        
        it(@"does blockForRowNumber right", ^{
            [[theValue([tableview numberOfRowsInSection:0]) should] equal:theValue(rowCount)];
        });
        
        it(@"does blockForCellProvider right", ^{
            for (int i = 0, j = [tableview numberOfRowsInSection:0]; i < j; i++) {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [tableview scrollToRowAtIndexPath:indexPath
                                 atScrollPosition:UITableViewScrollPositionNone
                                         animated:YES];
                UITableViewCell* cell = [tableview cellForRowAtIndexPath:indexPath];
                [[cell shouldNot] beNil];
                [[theValue(cell.tag) should] equal:theValue(i)];
            }
        });
        
    });
});


SPEC_END