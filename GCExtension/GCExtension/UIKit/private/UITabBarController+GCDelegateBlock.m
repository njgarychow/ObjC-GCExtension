//
//  UITabBarController+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabBarController+GCDelegateBlock.h"
#import "UITabbarControllerDelegateImplementationProxy.h"

#import <objc/runtime.h>
#import "NSObject+GCAccessor.h"

@implementation UITabBarController (GCDelegateBlock)

- (void)usingBlocks {
    static char UITabbarControllerDelegateImplementationProxyKey;
    UITabbarControllerDelegateImplementationProxy* tabbarDelegate = objc_getAssociatedObject(self, &UITabbarControllerDelegateImplementationProxyKey);
    if (!tabbarDelegate) {
        tabbarDelegate = [[UITabbarControllerDelegateImplementationProxy alloc] init];
        tabbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UITabbarControllerDelegateImplementationProxyKey, tabbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)tabbarDelegate;
}


@dynamic blockForShouldSelectViewController;
@dynamic blockForDidSelectViewController;
@dynamic blockForWillBeginCustomizingViewControllers;
@dynamic blockForWillEndCustomizingViewControllersChanged;
@dynamic blockForDidEndCustomizingViewControllersChanged;
@dynamic blockForSupportedInterfaceOrientations;
@dynamic blockForPreferredInterfaceOrientation;
@dynamic blockForAnimationForTransitionController;
@dynamic blockForInteractiveForAnimationController;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldSelectViewController",
             @"blockForDidSelectViewController",
             @"blockForWillBeginCustomizingViewControllers",
             @"blockForWillEndCustomizingViewControllersChanged",
             @"blockForDidEndCustomizingViewControllersChanged",
             @"blockForSupportedInterfaceOrientations",
             @"blockForPreferredInterfaceOrientation",
             @"blockForAnimationForTransitionController",
             @"blockForInteractiveForAnimationController"];
}

@end
