//
//  UIImagePickerController+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UIImagePickerController+GCDelegateBlock.h"

#import "UIImagePickerControllerDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UIImagePickerController (GCDelegateBlock)


- (void)usingBlocks {
    static char UIImagePickerControllerDelegateImplementationProxyKey;
    UIImagePickerControllerDelegateImplementationProxy* imagePickerDelegate = objc_getAssociatedObject(self, &UIImagePickerControllerDelegateImplementationProxyKey);
    if (!imagePickerDelegate) {
        imagePickerDelegate = [[UIImagePickerControllerDelegateImplementationProxy alloc] init];
        imagePickerDelegate.owner = self;
        objc_setAssociatedObject(self, &UIImagePickerControllerDelegateImplementationProxyKey, imagePickerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)imagePickerDelegate;
}


@dynamic blockForDidFinishPickingMedia;
@dynamic blockForDidCancel;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForDidFinishPickingMedia",
             @"blockForDidCancel"];
}

@end
