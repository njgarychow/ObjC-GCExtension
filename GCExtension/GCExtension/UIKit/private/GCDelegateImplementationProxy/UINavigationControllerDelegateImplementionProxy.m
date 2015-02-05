//
//  UINavigationControllerDelegateImplementionProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UINavigationControllerDelegateImplementionProxy.h"

#import "UINavigationController+GCDelegateBlock.h"


@implementation UINavigationControllerDelegateImplementation

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.blockForWillShowViewController(navigationController, viewController, animated);
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    navigationController.blockForDidShowViewController(navigationController, viewController, animated);
}

- (NSUInteger)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    return navigationController.blockForSupportedInterfaceOrientation(navigationController);
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
    return navigationController.blockForPreferedInterfaceOrientation(navigationController);
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return navigationController.blockForInteractionController(navigationController, animationController);
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    return navigationController.blockForAnimationForOperation(navigationController, operation, fromVC, toVC);
}

@end














@interface UINavigationControllerDelegateImplementionProxy ()

@property (nonatomic, strong) UINavigationControllerDelegateImplementation* realObject;

@end

@implementation UINavigationControllerDelegateImplementionProxy

- (instancetype)init {
    _realObject = [[UINavigationControllerDelegateImplementation alloc] init];
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
    BlockStatement(self.owner.blockForWillShowViewController, @"navigationController:willShowViewController:animated:");
    BlockStatement(self.owner.blockForDidShowViewController, @"navigationController:didShowViewController:animated:");
    BlockStatement(self.owner.blockForAnimationForOperation, @"navigationController:animationControllerForOperation:fromViewController:toViewController:");
    BlockStatement(self.owner.blockForInteractionController, @"navigationController:interactionControllerForAnimationController:");
    BlockStatement(self.owner.blockForPreferedInterfaceOrientation, @"navigationControllerPreferredInterfaceOrientationForPresentation:");
    BlockStatement(self.owner.blockForSupportedInterfaceOrientation, @"navigationControllerSupportedInterfaceOrientations:");
    
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
