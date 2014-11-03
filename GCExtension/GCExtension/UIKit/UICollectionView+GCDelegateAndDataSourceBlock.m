//
//  UICollectionView+GCDelegateAndDataSourceBlock.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"
#import "NSObject+GCAccessor.h"
#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"
#import <objc/runtime.h>

@implementation UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    static char const UICollectionViewDelegateAndDataSourceImplementationProxyKey;
    UICollectionViewDelegateAndDataSourceImplementationProxy* implement = nil;
    implement = objc_getAssociatedObject(self, &UICollectionViewDelegateAndDataSourceImplementationProxyKey);
    if (!implement) {
        implement = [[UICollectionViewDelegateAndDataSourceImplementationProxy alloc] init];
        implement.owner = self;
        objc_setAssociatedObject(self, &UICollectionViewDelegateAndDataSourceImplementationProxyKey, implement, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)implement;
    self.dataSource = (id)implement;
}


@dynamic blockForItemNumber;
@dynamic blockForSectionNumber;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForItemNumber",
             @"blockForSectionNumber"];
}

@end
