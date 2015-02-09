//
//  UIPickerView+GCDelegateAndDataSourceBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPickerView+GCDelegateAndDataSourceBlock.h"

#import "UIPickerViewDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UIPickerView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks {
    static char UIPickerViewDelegateImplementationProxyKey;
    UIPickerViewDelegateImplementationProxy* pickerDelegate = objc_getAssociatedObject(self, &UIPickerViewDelegateImplementationProxyKey);
    if (!pickerDelegate) {
        pickerDelegate = [[UIPickerViewDelegateImplementationProxy alloc] init];
        pickerDelegate.owner = self;
        objc_setAssociatedObject(self, &UIPickerViewDelegateImplementationProxyKey, pickerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)pickerDelegate;
}


@dynamic blockForRowHeightForComponent;
@dynamic blockForWidthForComponent;
@dynamic blockForTitltForRowForComponent;
@dynamic blockForAttributedTitleForRowForComponent;
@dynamic blockForViewForRowForComponentWithReusingView;
@dynamic blockForDidSelectRowInComponent;

@dynamic blockForNumberOfComponents;
@dynamic blockForNumberOfRowsInComponent;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForRowHeightForComponent",
             @"blockForWidthForComponent",
             @"blockForTitltForRowForComponent",
             @"blockForAttributedTitleForRowForComponent",
             @"blockForViewForRowForComponentWithReusingView",
             @"blockForDidSelectRowInComponent",
             @"blockForNumberOfComponents",
             @"blockForNumberOfRowsInComponent"];
}

@end
