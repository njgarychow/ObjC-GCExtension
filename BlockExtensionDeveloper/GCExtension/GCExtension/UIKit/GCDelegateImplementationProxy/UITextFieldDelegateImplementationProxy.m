//
//  UITextFieldDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-10-14.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UITextFieldDelegateImplementationProxy.h"
#import "UITextField+GCDelegateBlock.h"

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






@interface UITextFieldDelegateImplementationProxy()

@property (nonatomic, strong) UITextFieldDelegateImplementation* realObject;

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

