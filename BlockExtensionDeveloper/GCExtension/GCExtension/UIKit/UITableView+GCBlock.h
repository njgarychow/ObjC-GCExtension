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

#pragma mark - datasource property
typedef UITableViewCell* (^CellProviderBlock)(NSIndexPath* indexPath);
/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
@property (nonatomic, strong) CellProviderBlock cellProviderBlock;


typedef int (^SectionNumberBlock)();
/**
 *  equal to -> |numberOfSectionsInTableView:|
 */
@property (nonatomic, assign) SectionNumberBlock sectionNumberBlock;


typedef int (^RowNumberBlock)(int section);
/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
@property (nonatomic, strong) RowNumberBlock rowNumberBlock;


typedef NSArray* (^SectionIndexTitlesBlock)();
/**
 *  equal to -> |sectionIndexTitlesForTableView:|
 */
@property (nonatomic, strong) SectionIndexTitlesBlock sectionIndexTitlesBlock;


typedef int (^SectionIndex)(NSString* title, int index);
/**
 *  equal to -> |tableView:sectionForSectionIndexTitle:atIndex:|
 */
@property (nonatomic, strong) SectionIndex sectionIndex;






#pragma mark - delegate property

typedef float (^RowHeightBlock)(NSIndexPath* indexPath);
/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
@property (nonatomic, strong) RowHeightBlock rowHeightBlock;


typedef void (^RowDidSelectBlock)(NSIndexPath* indexPath);
/**
 *  equal to -> |tableView:didSelectRowAtIndexPath:|
 */
@property (nonatomic, strong) RowDidSelectBlock rowDidSelectBlock;


typedef void (^CellWillDisplayBlock)(UITableViewCell* cell, NSIndexPath* indexPath);
/**
 *  equal to -> |tableView:willDisplayCell:forRowAtIndexPath:|
 */
@property (nonatomic, strong) CellWillDisplayBlock cellWillDisplayBlock;


@end
