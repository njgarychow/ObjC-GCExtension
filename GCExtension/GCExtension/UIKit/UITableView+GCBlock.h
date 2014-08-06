//
//  UITableView+GCBlock.h
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  This extension uses the catagory of the UITableView to implement using block instead of
 *  the delegate and the dataSource.
 */
@interface UITableView (GCBlock) 

//  tableview datasource block

/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
typedef int (^RowNumberBlock)(int section);
@property (nonatomic, strong) RowNumberBlock rowNumberBlock;

/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
typedef UITableViewCell* (^CellProviderBlock)(NSIndexPath* indexPath);
@property (nonatomic, strong) CellProviderBlock cellProviderBlock;




//  tableview delegate block

/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
typedef float (^RowHeightBlock)(NSIndexPath* indexPath);
@property (nonatomic, strong) RowHeightBlock rowHeightBlock;

@end
