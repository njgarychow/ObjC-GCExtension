//
//  UIPopoverController+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPopoverController+GCDelegateBlock.h"
#import "UIPopoverControllerImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UIPopoverController (GCDelegateBlock)

- (void)usingBlocks {
    static char UIPopoverControllerImplementationProxyKey;
    UIPopoverControllerImplementationProxy* toolbarDelegate = objc_getAssociatedObject(self, &UIPopoverControllerImplementationProxyKey);
    if (!toolbarDelegate) {
        toolbarDelegate = [[UIPopoverControllerImplementationProxy alloc] init];
        toolbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UIPopoverControllerImplementationProxyKey, toolbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)toolbarDelegate;
}

@dynamic blockForWillRepositionToRectInView;
@dynamic blockForShouldDismiss;
@dynamic blockForDidDismiss;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForWillRepositionToRectInView",
             @"blockForShouldDismiss",
             @"blockForDidDismiss"];
}

@end
