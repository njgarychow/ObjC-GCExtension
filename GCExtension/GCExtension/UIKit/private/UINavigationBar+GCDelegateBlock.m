//
//  UINavigationBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UINavigationBar+GCDelegateBlock.h"
#import "UINavigationBarDelegateImpletationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (GCDelegateBlock)

- (void)usingBlocks {
    static char UINavigationBarDelegateImpletationProxyKey;
    UINavigationBarDelegateImpletationProxy* toolbarDelegate = objc_getAssociatedObject(self, &UINavigationBarDelegateImpletationProxyKey);
    if (!toolbarDelegate) {
        toolbarDelegate = [[UINavigationBarDelegateImpletationProxy alloc] init];
        toolbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UINavigationBarDelegateImpletationProxyKey, toolbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)toolbarDelegate;
}


@dynamic blockForShouldPushItem;
@dynamic blockForDidPushItem;
@dynamic blockForShouldPopItem;
@dynamic blockForDidPopItem;
@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldPushItem",
             @"blockForDidPushItem",
             @"blockForShouldPopItem",
             @"blockForDidPopItem",
             @"blockForPosition"];
}

@end
