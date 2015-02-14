//
//  UIToolbarDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIToolbarDelegateImplementationProxy.h"
#import "UIToolbar+GCDelegateBlock.h"

@interface UIToolbarDelegateImplementation : NSObject <UIToolbarDelegate>

@end

@implementation UIToolbarDelegateImplementation

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return ((UIToolbar *)bar).blockForPosition((UIToolbar *)bar);
}

@end








@interface UIToolbarDelegateImplementationProxy ()

@property (nonatomic, strong) UIToolbarDelegateImplementation* realObject;

@end

@implementation UIToolbarDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UIToolbarDelegateImplementation alloc] init];
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
