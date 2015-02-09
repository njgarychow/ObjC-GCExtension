//
//  UITabBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBar+GCDelegateBlock.h"

#import "UITabbarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UITabBar (GCDelegateBlock)

- (void)usingBlocks {
    static char UITabbarDelegateImplementationProxyKey;
    UITabbarDelegateImplementationProxy* tabbarDelegate = objc_getAssociatedObject(self, &UITabbarDelegateImplementationProxyKey);
    if (!tabbarDelegate) {
        tabbarDelegate = [[UITabbarDelegateImplementationProxy alloc] init];
        tabbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UITabbarDelegateImplementationProxyKey, tabbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)tabbarDelegate;
}


@dynamic blockForWillBeginCustomizingItems;
@dynamic blockForDidBeginCustomzingItems;
@dynamic blockForWillEndCustomizingItems;
@dynamic blockForDidEndCustomzingItems;
@dynamic blockForDidSelectItem;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForWillBeginCustomizingItems",
             @"blockForDidBeginCustomzingItems",
             @"blockForWillEndCustomizingItems",
             @"blockForDidEndCustomzingItems",
             @"blockForDidSelectItem"];
}


@end
