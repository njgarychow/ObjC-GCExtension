//
//  UITextField+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextField+GCDelegateBlock.h"
#import "NSObject+GCAccessor.h"
#import <objc/runtime.h>


@interface UITextFieldDelegateImplementation : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) UITextField* owner;

@end

@implementation UITextFieldDelegateImplementation

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return self.owner.blockForShouldBeginEditing(textField);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.owner.blockForDidBeginEditing(textField);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return self.owner.blockForShouldEndEditing(textField);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.owner.blockForDidEndEditing(textField);
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return self.owner.blockForShouldReplacementString(textField, range, string);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return self.owner.blockForShouldClear(textField);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return self.owner.blockForShouldReturn(textField);
}

@end





@interface UITextFieldDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UITextField* owner;
@property (nonatomic, strong) UITextFieldDelegateImplementation* realObject;

- (id)init;

@end

@implementation UITextFieldDelegateImplementationProxy

- (id)init {
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(block, selectorString) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(block, selectorString))
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    BlockStatement(self.owner.blockForShouldBeginEditing, @"textFieldShouldBeginEditing:");
    BlockStatement(self.owner.blockForDidBeginEditing, @"textFieldDidBeginEditing:");
    BlockStatement(self.owner.blockForShouldEndEditing, @"textFieldShouldEndEditing:");
    BlockStatement(self.owner.blockForDidEndEditing, @"textFieldDidEndEditing:");
    BlockStatement(self.owner.blockForShouldReplacementString, @"textField:shouldChangeCharactersInRange:replacementString:");
    BlockStatement(self.owner.blockForShouldClear, @"textFieldShouldClear:");
    BlockStatement(self.owner.blockForShouldReturn, @"textFieldShouldReturn:");
    
    return NO;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.realObject methodSignatureForSelector:sel];
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.realObject];
}

@end






@implementation UITextField (GCDelegateBlock)

static char UITextFieldDelegateImplementationProxyKey;
- (void)usingDelegateBlocks {
    UITextFieldDelegateImplementationProxy* proxy = objc_getAssociatedObject(self, &UITextFieldDelegateImplementationProxyKey);
    if (!proxy) {
        proxy = [[UITextFieldDelegateImplementationProxy alloc] init];
        proxy.owner = self;
        objc_setAssociatedObject(self, &UITextFieldDelegateImplementationProxyKey, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.delegate = (id)proxy;
}


@dynamic blockForShouldBeginEditing;
@dynamic blockForDidBeginEditing;
@dynamic blockForShouldEndEditing;
@dynamic blockForDidEndEditing;
@dynamic blockForShouldReplacementString;
@dynamic blockForShouldClear;
@dynamic blockForShouldReturn;

+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldBeginEditing",
             @"blockForDidBeginEditing",
             @"blockForShouldEndEditing",
             @"blockForDidEndEditing",
             @"blockForShouldReplacementString",
             @"blockForShouldClear",
             @"blockForShouldReturn"];
}

@end
