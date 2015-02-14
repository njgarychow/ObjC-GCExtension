//
//  UISearchBarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UISearchBarDelegateImplementationProxy.h"
#import "UISearchBar+GCDelegateBlock.h"


@interface UISearchBarDelegateImplementation : NSObject <UISearchBarDelegate>

@end


@implementation UISearchBarDelegateImplementation

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return searchBar.blockForShouldBeginEditing(searchBar);
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.blockForTextDidBeginEditing(searchBar);
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return searchBar.blockForShouldEndEditing(searchBar);
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.blockForTextDidEndEditing(searchBar);
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchBar.blockForTextDidChange(searchBar, searchText);
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return searchBar.blockForShouldChangeText(searchBar, range, text);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForSearchButtonClicked(searchBar);
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForBookmarkButtonClicked(searchBar);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForCancelButtonClicked(searchBar);
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    searchBar.blockForResultsListButtonClicked(searchBar);
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    searchBar.blockForSelectedScopeButtonIndexDidChange(searchBar, selectedScope);
}
- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UISearchBar *)bar).blockForPosition((UISearchBar *)bar);
}

@end







@interface UISearchBarDelegateImplementationProxy ()

@property (nonatomic, strong) UISearchBarDelegateImplementation* realObject;

@end

@implementation UISearchBarDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UISearchBarDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(selectorString, block) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(selectorString, block))

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    /**
     *  BlcokStatement expand:
     *  if (|block| && [|selectorString| isEqualToString:targetSelectorString]) {
     *      return YES;
     *  }
     */
    BlockStatement(self.owner.blockForTextDidChange, @"searchBar:textDidChange:");
    BlockStatement(self.owner.blockForShouldChangeText, @"searchBar:shouldChangeTextInRange:replacementText:");
    BlockStatement(self.owner.blockForShouldBeginEditing, @"searchBarShouldBeginEditing:");
    BlockStatement(self.owner.blockForTextDidBeginEditing, @"searchBarTextDidBeginEditing:");
    BlockStatement(self.owner.blockForShouldEndEditing, @"blockForShouldEndEditing:");
    BlockStatement(self.owner.blockForTextDidEndEditing, @"searchBarTextDidEndEditing:");
    BlockStatement(self.owner.blockForBookmarkButtonClicked, @"searchBarBookmarkButtonClicked:");
    BlockStatement(self.owner.blockForCancelButtonClicked, @"searchBarCancelButtonClicked:");
    BlockStatement(self.owner.blockForSearchButtonClicked, @"blockForSearchButtonClicked:");
    BlockStatement(self.owner.blockForResultsListButtonClicked, @"searchBarResultsListButtonClicked:");
    BlockStatement(self.owner.blockForSelectedScopeButtonIndexDidChange, @"searchBar:selectedScopeButtonIndexDidChange:");
    BlockStatement(self.owner.blockForPosition, @"positionForBar:");
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

- (void)dealloc {
    if (self == self.owner.delegate) {
        self.owner.delegate = nil;
    }
}

@end
