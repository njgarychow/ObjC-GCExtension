//
//  UISearchBar+GCDelegateBlock.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UISearchBar+GCDelegateBlock.h"
#import "UISearchBarDelegateImplementationProxy.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>

@implementation UISearchBar (GCDelegateBlock)

- (void)usingBlocks {
    static char UISearchBarDelegateImplementationProxyKey;
    UISearchBarDelegateImplementationProxy* searchbarDelegate = objc_getAssociatedObject(self, &UISearchBarDelegateImplementationProxyKey);
    if (!searchbarDelegate) {
        searchbarDelegate = [[UISearchBarDelegateImplementationProxy alloc] init];
        searchbarDelegate.owner = self;
        objc_setAssociatedObject(self, &UISearchBarDelegateImplementationProxyKey, searchbarDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = nil;
    self.delegate = (id)searchbarDelegate;
}

@dynamic blockForTextDidChange;
@dynamic blockForShouldChangeText;
@dynamic blockForShouldBeginEditing;
@dynamic blockForTextDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForTextDidEndEditing;
@dynamic blockForBookmarkButtonClicked;
@dynamic blockForCancelButtonClicked;
@dynamic blockForSearchButtonClicked;
@dynamic blockForResultsListButtonClicked;
@dynamic blockForSelectedScopeButtonIndexDidChange;
@dynamic blockForPosition;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForTextDidChange",
             @"blockForShouldChangeText",
             @"blockForShouldBeginEditing",
             @"blockForTextDidBeginEditing",
             @"blockForShouldEndEditing",
             @"blockForTextDidEndEditing",
             @"blockForBookmarkButtonClicked",
             @"blockForCancelButtonClicked",
             @"blockForSearchButtonClicked",
             @"blockForResultsListButtonClicked",
             @"blockForSelectedScopeButtonIndexDidChange",
             @"blockForPosition"];
}

@end
