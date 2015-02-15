//
//  UIPopoverControllerImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPopoverControllerImplementationProxy.h"
#import "UIPopoverController+GCDelegateBlock.h"

@interface UIPopoverControllerImplementation : NSObject <UIPopoverControllerDelegate>

@end

@implementation UIPopoverControllerImplementation

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return popoverController.blockForShouldDismiss(popoverController);
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    popoverController.blockForDidDismiss(popoverController);
}

- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView **)view {
    popoverController.blockForWillRepositionToRectInView(popoverController, rect, view);
}

@end







@interface UIPopoverControllerImplementationProxy ()

@property (nonatomic, strong) UIPopoverControllerImplementation* realObject;

@end

@implementation UIPopoverControllerImplementationProxy

- (instancetype)init {
    _realObject = [[UIPopoverControllerImplementation alloc] init];
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
    BlockStatement(self.owner.blockForWillRepositionToRectInView, @"popoverController:willRepositionPopoverToRect:inView:");
    BlockStatement(self.owner.blockForShouldDismiss, @"popoverControllerShouldDismissPopover:");
    BlockStatement(self.owner.blockForDidDismiss, @"popoverControllerDidDismissPopover:");
    
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
