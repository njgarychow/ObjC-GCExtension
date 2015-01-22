//
//  UITableView+GCDelegateAndDataSource.m
//  GCExtension
//
//  Created by njgarychow on 1/22/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCDelegateAndDataSource.h"

#import "UITableView+GCDelegateAndDataSourceBlock.h"

@implementation UITableView (GCDelegateAndDataSource)

- (instancetype)withBlockForRowCell:(UITableViewCell* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCell = block;
    [self usingBlocks];
    return self;
}

- (instancetype)withBlockForSectionNumber:(NSInteger (^)(UITableView* view))block {
    self.blockForSectionNumber = block;
    return self;
}

- (instancetype)withBlockForRowNumber:(NSInteger (^)(UITableView* view, NSInteger section))block {
    self.blockForRowNumber = block;
    return self;
}

- (instancetype)withBlockForSectionIndexTitles:(NSArray* (^)(UITableView* view))block {
    self.blockForSectionIndexTitles = block;
    return self;
}

- (instancetype)withBlockForSectionIndex:(NSInteger (^)(UITableView* view, NSString* title, NSInteger index))block {
    self.blockForSectionIndex = block;
    return self;
}

- (instancetype)withBlockForFooterTitle:(NSString* (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterTitle = block;
    return self;
}

- (instancetype)withBlockForHeaderTitle:(NSString* (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderTitle = block;
    return self;
}

- (instancetype)withBlockForRowCommitEditStyleForRow:(void (^)(UITableView* view, UITableViewCellEditingStyle style, NSIndexPath* path))block {
    self.blockForRowCommitEditStyleForRow = block;
    return self;
}

- (instancetype)withBlockForRowCanEdit:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCanEditRow = block;
    return self;
}

- (instancetype)withBlockForRowCanMove:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowCanMoveRow = block;
    return self;
}

- (instancetype)withBlockForRowMove:(void (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* toPath))block {
    self.blockForRowMove = block;
    return self;
}







#pragma mark - delegate property

- (instancetype)withBlockForRowHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowHeight = block;
    return self;
}

- (instancetype)withBlockForRowEstimatedHeight:(CGFloat (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEstimatedHeight = block;
    return self;
}

- (instancetype)withBlockForRowIndentationLevel:(NSInteger (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowIndentationLevel = block;
    return self;
}

- (instancetype)withBlockForRowCellWillDisplay:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block {
    self.blockForRowCellWillDisplay = block;
    return self;
}

- (instancetype)withBlockForRowEditActions:(NSArray* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEditActions = block;
    return self;
}

- (instancetype)withBlockForRowAccessoryButtonTapped:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowAccessoryButtonTapped = block;
    return self;
}

- (instancetype)withBlockForRowWillSelect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillSelect = block;
    return self;
}

- (instancetype)withBlockForRowDidSelect:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidSelect = block;
    return self;
}

- (instancetype)withBlockForRowWillDeselect:(NSIndexPath* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillDeselect = block;
    return self;
}

- (instancetype)withBlockForRowDidDeselect:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidDeselecte = block;
    return self;
}

- (instancetype)withBlockForHeaderView:(UIView* (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderView = block;
    return self;
}

- (instancetype)withBlockForFooterView:(UIView* (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterView = block;
    return self;
}

- (instancetype)withBlockForHeaderHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderHeight = block;
    return self;
}

- (instancetype)withBlockForHeaderEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForHeaderEstimatedHeight = block;
    return self;
}

- (instancetype)withBlockForFooterHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterHeight = block;
    return self;
}

- (instancetype)withBlockForFooterEstimatedHeight:(CGFloat (^)(UITableView* view, NSInteger section))block {
    self.blockForFooterEstimatedHeight = block;
    return self;
}

- (instancetype)withBlockForHeaderViewWillDisplay:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block {
    self.blockForHeaderViewWillDisplay = block;
    return self;
}

- (instancetype)withBlockForFooterViewWillDisplay:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block {
    self.blockForFooterViewWillDisplay = block;
    return self;
}

- (instancetype)withBlockForRowWillBeginEditing:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowWillBeginEditing = block;
    return self;
}

- (instancetype)withBlockForRowDidEditing:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidEndEditing = block;
    return self;
}

- (instancetype)withBlockForRowEditingStyle:(UITableViewCellEditingStyle (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowEditingStyle = block;
    return self;
}

- (instancetype)withBlockForRowDeleteConfirmationButtonTitle:(NSString* (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDeleteConfirmationButtonTitle = block;
    return self;
}

- (instancetype)withBlockForRowShouldIndentWhileEditing:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldIndentWhileEditing = block;
    return self;
}

- (instancetype)withBlockForRowMoveTargetIndexPath:(NSIndexPath* (^)(UITableView* view, NSIndexPath* fromPath, NSIndexPath* proposedPath))block {
    self.blockForRowMoveTargetIndexPath = block;
    return self;
}

- (instancetype)withBlockForRowDidEndDisplayingCell:(void (^)(UITableView* view, UITableViewCell* cell, NSIndexPath* path))block {
    self.blockForRowDidEndDisplayingCell = block;
    return self;
}

- (instancetype)withBlockForHeaderViewDidEndDisplaying:(void (^)(UITableView* view, UIView* headerView, NSInteger section))block {
    self.blockForHeaderViewDidEndDisplaying = block;
    return self;
}

- (instancetype)withBlockForFooterViewDidEndDisplaying:(void (^)(UITableView* view, UIView* footerView, NSInteger section))block {
    self.blockForFooterViewDidEndDisplaying = block;
    return self;
}

- (instancetype)withBlockForRowShouldShowMenu:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldShowMenu = block;
    return self;
}

- (instancetype)withBlockForRowCanPerformAction:(BOOL (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block {
    self.blockForRowCanPerformAction = block;
    return self;
}

- (instancetype)withBlockForRowPerformAction:(void (^)(UITableView* view, SEL action, NSIndexPath* path, id sender))block {
    self.blockForRowPerformAction = block;
    return self;
}

- (instancetype)withBlockForRowShouldHighlight:(BOOL (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowShouldHighlight = block;
    return self;
}

- (instancetype)withBlockForRowDidHighlight:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidHighlight = block;
    return self;
}

- (instancetype)withBlockForRowDidUnhighlight:(void (^)(UITableView* view, NSIndexPath* path))block {
    self.blockForRowDidUnhighlight = block;
    return self;
}

@end
