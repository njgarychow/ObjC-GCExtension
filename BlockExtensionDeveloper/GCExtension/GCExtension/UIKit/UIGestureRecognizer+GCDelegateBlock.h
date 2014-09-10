//
//  UIGestureRecognizer+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (GCDelegateBlock)

@property (nonatomic, copy) BOOL (^blockForShouldBegin)();
@property (nonatomic, copy) BOOL (^blockForShouldReceiveTouch)(UITouch* touch);
@property (nonatomic, copy) BOOL (^blockForShouldSimultaneous)(UIGestureRecognizer* otherGesture);

@property (nonatomic, copy) BOOL (^blockForShouldRequireFailureOf)(UIGestureRecognizer* otherGesture);
@property (nonatomic, copy) BOOL (^blockForShouldBeRequireToFailureBy)(UIGestureRecognizer* otherGesture);

- (void)usingDelegateBlocks;

@end
