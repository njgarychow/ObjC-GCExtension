//
//  UITableView+GCBlock.m
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCBlock.h"

#import <objc/runtime.h>
#import "GCMacro.h"
#import "GCExtensionAccessorGeneratorMacro.h"

@interface BlockTableViewDelegateAndDataSourceImplementation : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView* owner;

@end

@implementation BlockTableViewDelegateAndDataSourceImplementation

#pragma mark - UITableView Datasource method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(_owner.blockForCellProvider, @"the tableview's |cellProviderBlock| can't be nil.");
    return _owner.blockForCellProvider(indexPath);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_owner.blockForSectionNumber) {
        return 1;
    }
    return _owner.blockForSectionNumber();
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSAssert(_owner.blockForRowNumber, @"the tableview's |rowNumberBlock| can't be nil.");
    return _owner.blockForRowNumber((int)section);
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!_owner.blockForSectionIndexTitles) {
        return nil;
    }
    return _owner.blockForSectionIndexTitles();
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (!_owner.blockForSectionIndex) {
        return 0;
    }
    return _owner.blockForSectionIndex(title, index);
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (!_owner.blockForFooterTitle) {
        return nil;
    }
    return _owner.blockForFooterTitle(section);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!_owner.blockForHeaderTitle) {
        return nil;
    }
    return _owner.blockForHeaderTitle(section);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForCommitEditStyleForRow) {
        return;
    }
    _owner.blockForCommitEditStyleForRow(editingStyle, indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForCanEditRow) {
        return NO;
    }
    return _owner.blockForCanEditRow(indexPath);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForCanMoveRow) {
        return NO;
    }
    return _owner.blockForCanMoveRow(indexPath);
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (!_owner.blockForMoveRow) {
        return;
    }
    _owner.blockForMoveRow(sourceIndexPath, destinationIndexPath);
}

#pragma mark - UITableView Delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForRowHeight) {
        return 44.0f;
    }
    return _owner.blockForRowHeight(indexPath);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForRowDidSelect) {
        return;
    }
    _owner.blockForRowDidSelect(indexPath);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_owner.blockForCellWillDisplay) {
        return;
    }
    _owner.blockForCellWillDisplay(cell, indexPath);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_owner.blockForHeaderView) {
        return nil;
    }
    return _owner.blockForHeaderView(section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!_owner.blockForHeaderHeight) {
        return 0;
    }
    return _owner.blockForHeaderHeight(section);
}

#pragma mark - dealloc


- (void)dealloc {
    if (self == _owner.delegate) {
        _owner.delegate = nil;
    }
    if (self == _owner.dataSource) {
        _owner.dataSource = nil;
    }
}

@end


#pragma mark - UITableView+GCBlock

@implementation UITableView (GCBlock)

- (void)usingBlocks {
    static char const BlockTableViewDelegateAndDataSourceImplementationKey;
    BlockTableViewDelegateAndDataSourceImplementation* implement = nil;
    implement = objc_getAssociatedObject(self, &BlockTableViewDelegateAndDataSourceImplementationKey);
    if (!implement) {
        implement = [[BlockTableViewDelegateAndDataSourceImplementation alloc] init];
        implement.owner = self;
        objc_setAssociatedObject(self, &BlockTableViewDelegateAndDataSourceImplementationKey, implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = implement;
    self.dataSource = implement;
}

@dynamic blockForCellProvider;
@dynamic blockForSectionNumber;
@dynamic blockForRowNumber;
@dynamic blockForSectionIndexTitles;
@dynamic blockForSectionIndex;
@dynamic blockForFooterTitle;
@dynamic blockForHeaderTitle;
@dynamic blockForCommitEditStyleForRow;
@dynamic blockForCanEditRow;
@dynamic blockForCanMoveRow;
@dynamic blockForMoveRow;

@dynamic blockForRowHeight;
@dynamic blockForRowDidSelect;
@dynamic blockForCellWillDisplay;
@dynamic blockForHeaderView;
@dynamic blockForHeaderHeight;

@end

GCExtensionClassAccessorGenerator(UITableView)
GCExtensionClassNonatomicCopyAccessorGenerator(UITableView,
                                               blockForCanEditRow,
                                               blockForCanMoveRow,
                                               blockForCellProvider,
                                               blockForCellWillDisplay,
                                               blockForCommitEditStyleForRow,
                                               blockForFooterTitle,
                                               blockForHeaderHeight,
                                               blockForHeaderTitle,
                                               blockForHeaderView,
                                               blockForMoveRow,
                                               blockForRowDidSelect,
                                               blockForRowHeight,
                                               blockForSectionIndex,
                                               blockForSectionIndexTitles,
                                               blockForSectionNumber,
                                               blockForRowNumber);
