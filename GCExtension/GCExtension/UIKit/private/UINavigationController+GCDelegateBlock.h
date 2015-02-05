//
//  UINavigationController+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |navigationController:willShowViewController:animated:|
 */
@property (nonatomic, copy) void (^blockForWillShowViewController)(UINavigationController* navi, UIViewController* vc, BOOL animated);

/**
 *  equal to -> |navigationController:didShowViewController:animated:|
 */
@property (nonatomic, copy) void (^blockForDidShowViewController)(UINavigationController* navi, UIViewController* vc, BOOL animated);

/**
 *  equal to -> |navigationController:animationControllerForOperation:fromViewController:toViewController:|
 */
@property (nonatomic, copy) id<UIViewControllerAnimatedTransitioning> (^blockForAnimationForOperation)(UINavigationController* navi, UINavigationControllerOperation operation, UIViewController* fromVC, UIViewController* toVC);

/**
 *  equal to -> |navigationController:interactionControllerForAnimationController:|
 */
@property (nonatomic, copy) id<UIViewControllerInteractiveTransitioning> (^blockForInteractionController)(UINavigationController* navi, id<UIViewControllerAnimatedTransitioning> animateionController);

/**
 *  equal to -> |navigationControllerPreferredInterfaceOrientationForPresentation:|
 */
@property (nonatomic, copy) UIInterfaceOrientation (^blockForPreferedInterfaceOrientation)(UINavigationController* navi);

/**
 *  equal to -> |navigationControllerSupportedInterfaceOrientations:|
 */
@property (nonatomic, copy) NSUInteger (^blockForSupportedInterfaceOrientation)(UINavigationController* navi);

@end
