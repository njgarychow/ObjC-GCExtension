//
//  UIToolbar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIToolbar+GCDelegateBlock.h"
#import "UIToolbarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>


@implementation UIToolbar (GCDelegateBlock)


- (void)usingBlocks {
    static char UIToolbarDelegateImplementationProxyKey;
    UIToolbarDelegateImplementationProxy* toolbarDelegate = objc_getAssociatedObject(self, &UIToolbarDelegateImplementationProxyKey);
    if (!toolbarDelegate) {
        toolbarDelegate = [[UIToolbarDelegateImplementationProxy alloc] init];
        toolbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UIToolbarDelegateImplementationProxyKey, toolbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)toolbarDelegate;
}

@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForPosition"];
}

@end
