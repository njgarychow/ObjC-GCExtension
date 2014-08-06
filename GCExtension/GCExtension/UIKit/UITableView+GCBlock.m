//
//  UITableView+GCBlock.m
//  IPSShelf
//
//  Created by zhoujinqiang on 14-8-6.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITableView+GCBlock.h"

#import <objc/runtime.h>

@interface BlockTableViewDelegateAndDataSourceImplementation : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView* owner;

@end

@implementation BlockTableViewDelegateAndDataSourceImplementation

#pragma mark - UITableView Datasource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _owner.rowNumberBlock((int)section);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _owner.cellProviderBlock(indexPath);
}

#pragma mark - UITableView Delegate method

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _owner.rowHeightBlock(indexPath);
}

@end








#pragma mark - UITableView+GCBlock

@implementation UITableView (GCBlock)

static char const BlockDictionaryKey;
- (NSMutableDictionary *)blocks {
    NSMutableDictionary* blocksDic = objc_getAssociatedObject(self, &BlockDictionaryKey);
    if (!blocksDic) {
        blocksDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &BlockDictionaryKey, blocksDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return blocksDic;
}
- (NSString *)_getBlockKeyStringWithGetOrSetSelector:(SEL)selector {
    NSString* selectorName = [NSStringFromSelector(selector) lowercaseString];
    return [selectorName stringByReplacingOccurrencesOfString:@"(^set|:)"
                                                   withString:@""
                                                      options:NSRegularExpressionSearch
                                                        range:NSMakeRange(0, [selectorName length])];
}
- (void)_setBlockThroughoutSelector:(SEL)selector block:(id)block {
    NSString* blockKey = [self _getBlockKeyStringWithGetOrSetSelector:selector];
    if (block) {
        [[self blocks] setObject:block forKey:blockKey];
    }
    else {
        [[self blocks] removeObjectForKey:blockKey];
    }
}
- (id)_getBlockThroughoutSelector:(SEL)selector {
    NSString* blockKey = [self _getBlockKeyStringWithGetOrSetSelector:selector];
    return [[self blocks] objectForKey:blockKey];
}

- (void)_checkDelegateAndDataSource {
    if (!self.delegate && !self.dataSource) {
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
}


#pragma mark - properties getter and setter methods


#define getter_code_macro()                 return [self _getBlockThroughoutSelector:_cmd];
#define setter_code_macro(blockParam)       [self _checkDelegateAndDataSource];     \
                                            [self _setBlockThroughoutSelector:_cmd block:blockParam];
@dynamic rowHeightBlock;
- (void)setRowHeightBlock:(RowHeightBlock)rowHeightBlock {
    setter_code_macro(rowHeightBlock);
}
- (RowHeightBlock)rowHeightBlock {
    getter_code_macro();
}

@dynamic rowNumberBlock;
- (void)setRowNumberBlock:(RowNumberBlock)rowNumberBlock {
    setter_code_macro(rowNumberBlock);
}
- (RowNumberBlock)rowNumberBlock {
    getter_code_macro();
}

@dynamic cellProviderBlock;
- (void)setCellProviderBlock:(CellProviderBlock)cellProviderBlock {
    setter_code_macro(cellProviderBlock);
}
- (CellProviderBlock)cellProviderBlock {
    getter_code_macro();
}



@end
