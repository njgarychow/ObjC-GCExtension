//
//  UITabbarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabbarDelegateImplementationProxy.h"
#import "UITabBar+GCDelegateBlock.h"


@interface UITabbarDelegateImplementation : NSObject <UITabBarDelegate>

@end

@implementation UITabbarDelegateImplementation

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    tabBar.blockForDidSelectItem(tabBar, item);
}

- (void)tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items {
    tabBar.blockForWillBeginCustomizingItems(tabBar, items);
}
- (void)tabBar:(UITabBar *)tabBar didBeginCustomizingItems:(NSArray *)items {
    tabBar.blockForDidBeginCustomzingItems(tabBar, items);
}
- (void)tabBar:(UITabBar *)tabBar willEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
    tabBar.blockForWillEndCustomizingItems(tabBar, items, changed);
}
- (void)tabBar:(UITabBar *)tabBar didEndCustomizingItems:(NSArray *)items changed:(BOOL)changed {
    tabBar.blockForDidEndCustomzingItems(tabBar, items, changed);
}

@end








@interface UITabbarDelegateImplementationProxy ()

@property (nonatomic, strong) UITabbarDelegateImplementation* realObject;

@end

@implementation UITabbarDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UITabbarDelegateImplementation alloc] init];
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
    BlockStatement(self.owner.blockForWillBeginCustomizingItems, @"tabBar:willBeginCustomizingItems:");
    BlockStatement(self.owner.blockForDidBeginCustomzingItems, @"tabBar:didBeginCustomizingItems:");
    BlockStatement(self.owner.blockForWillEndCustomizingItems, @"tabBar:willEndCustomizingItems:changed:");
    BlockStatement(self.owner.blockForDidEndCustomzingItems, @"tabBar:didEndCustomizingItems:changed:");
    BlockStatement(self.owner.blockForDidSelectItem, @"tabBar:didSelectItem:");
    
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
