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
/**
 *  equal to -> |tableView:cellForRowAtIndexPath:|
 */
@property (nonatomic, copy) UITableViewCell* (^blockForCellProvider)(NSIndexPath* indexPath);


/**
 *  equal to -> |numberOfSectionsInTableView:|
 */
@property (nonatomic, copy) int (^blockForSectionNumber)();


/**
 *  equal to -> |tableView:numberOfRowsInSection:|
 */
@property (nonatomic, copy) int (^blockForRowNumber)(int section);


/**
 *  equal to -> |sectionIndexTitlesForTableView:|
 */
@property (nonatomic, copy) NSArray* (^blockForSectionIndexTitles)();


/**
 *  equal to -> |tableView:sectionForSectionIndexTitle:atIndex:|
 */
@property (nonatomic, copy) int (^blockForSectionIndex)(NSString* title, int index);






#pragma mark - delegate property

/**
 *  equal to -> |tableView:heightForRowAtIndexPath:|
 */
@property (nonatomic, copy) float (^blockForRowHeight)(NSIndexPath* indexPath);


/**
 *  equal to -> |tableView:didSelectRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForRowDidSelect)(NSIndexPath* indexPath);


/**
 *  equal to -> |tableView:willDisplayCell:forRowAtIndexPath:|
 */
@property (nonatomic, copy) void (^blockForCellWillDisplay)(UITableViewCell* cell, NSIndexPath* indexPath);


@end