//
//  UITabbarControllerDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UITabbarControllerDelegateImplementationProxy.h"
#import "UITabBarController+GCDelegateBlock.h"


@interface UITabbarControllerDelegateImplementation : NSObject <UITabBarControllerDelegate>
@end

@implementation UITabbarControllerDelegateImplementation

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return tabBarController.blockForShouldSelectViewController(tabBarController, viewController);
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    tabBarController.blockForDidSelectViewController(tabBarController, viewController);
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers {
    tabBarController.blockForWillBeginCustomizingViewControllers(tabBarController, viewControllers);
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    tabBarController.blockForWillEndCustomizingViewControllersChanged(tabBarController, viewControllers, changed);
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    tabBarController.blockForDidEndCustomizingViewControllersChanged(tabBarController, viewControllers, changed);
}

- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController {
    return tabBarController.blockForSupportedInterfaceOrientations(tabBarController);
}
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController {
    return tabBarController.blockForPreferredInterfaceOrientation(tabBarController);
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return tabBarController.blockForInteractiveForAnimationController(tabBarController, animationController);
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC {
    return tabBarController.blockForAnimationForTransitionController(tabBarController, fromVC, toVC);
}

@end








@interface UITabbarControllerDelegateImplementationProxy ()

@property (nonatomic, strong) UITabbarControllerDelegateImplementation* realObject;

@end

@implementation UITabbarControllerDelegateImplementationProxy


- (instancetype)init {
    _realObject = [[UITabbarControllerDelegateImplementation alloc] init];
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
    BlockStatement(self.owner.blockForShouldSelectViewController, @"tabBarController:shouldSelectViewController:");
    BlockStatement(self.owner.blockForDidSelectViewController, @"tabBarController:didSelectViewController:");
    BlockStatement(self.owner.blockForWillBeginCustomizingViewControllers, @"tabBarController:willBeginCustomizingViewControllers:");
    BlockStatement(self.owner.blockForWillEndCustomizingViewControllersChanged, @"tabBarController:willEndCustomizingViewControllers:changed:");
    BlockStatement(self.owner.blockForDidEndCustomizingViewControllersChanged, @"tabBarController:didEndCustomizingViewControllers:changed:");
    BlockStatement(self.owner.blockForSupportedInterfaceOrientations, @"blockForSupportedInterfaceOrientations:");
    BlockStatement(self.owner.blockForPreferredInterfaceOrientation, @"tabBarControllerPreferredInterfaceOrientationForPresentation:");
    BlockStatement(self.owner.blockForAnimationForTransitionController, @"tabBarController:animationControllerForTransitionFromViewController:toViewController:");
    BlockStatement(self.owner.blockForInteractiveForAnimationController, @"tabBarController:interactionControllerForAnimationController:");
    
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
