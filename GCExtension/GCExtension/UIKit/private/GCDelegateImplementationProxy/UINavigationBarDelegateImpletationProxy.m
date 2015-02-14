//
//  UINavigationBarDelegateImpletationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UINavigationBarDelegateImpletationProxy.h"
#import "UINavigationBar+GCDelegateBlock.h"

@interface UINavigationBarDelegateImpletation : NSObject <UINavigationBarDelegate>

@end

@implementation UINavigationBarDelegateImpletation

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    return navigationBar.blockForShouldPushItem(navigationBar, item);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {
    navigationBar.blockForDidPushItem(navigationBar, item);
}
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    return navigationBar.blockForShouldPopItem(navigationBar, item);
}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    navigationBar.blockForDidPopItem(navigationBar, item);
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UINavigationBar *)bar).blockForPosition((UINavigationBar *)bar);
}


@end






@interface UINavigationBarDelegateImpletationProxy ()

@property (nonatomic, strong) UINavigationBarDelegateImpletation* realObject;

@end

@implementation UINavigationBarDelegateImpletationProxy

- (instancetype)init {
    _realObject = [[UINavigationBarDelegateImpletation alloc] init];
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
    BlockStatement(self.owner.blockForShouldPushItem, @"navigationBar:shouldPushItem:");
    BlockStatement(self.owner.blockForDidPushItem, @"navigationBar:didPushItem:");
    BlockStatement(self.owner.blockForShouldPopItem, @"navigationBar:shouldPopItem:");
    BlockStatement(self.owner.blockForDidPopItem, @"navigationBar:didPopItem:");
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
