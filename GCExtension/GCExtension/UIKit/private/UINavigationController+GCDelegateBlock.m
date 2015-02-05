//
//  UINavigationController+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UINavigationController+GCDelegateBlock.h"
#import "UINavigationControllerDelegateImplementionProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UINavigationController (GCDelegateBlock)

- (void)usingBlocks {
    static char UINavigationControllerDelegateImplementionProxyKey;
    UINavigationControllerDelegateImplementionProxy* navigationDelegate = objc_getAssociatedObject(self, &UINavigationControllerDelegateImplementionProxyKey);
    if (!navigationDelegate) {
        navigationDelegate = [[UINavigationControllerDelegateImplementionProxy alloc] init];
        navigationDelegate.owner = self;
        objc_setAssociatedObject(self, &UINavigationControllerDelegateImplementionProxyKey, navigationDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)navigationDelegate;
}


@dynamic blockForWillShowViewController;
@dynamic blockForDidShowViewController;
@dynamic blockForAnimationForOperation;
@dynamic blockForInteractionController;
@dynamic blockForPreferedInterfaceOrientation;
@dynamic blockForSupportedInterfaceOrientation;


+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForWillShowViewController",
             @"blockForDidShowViewController",
             @"blockForAnimationForOperation",
             @"blockForInteractionController",
             @"blockForPreferedInterfaceOrientation",
             @"blockForSupportedInterfaceOrientation"];
}

@end
