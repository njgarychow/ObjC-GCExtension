//
//  UIGestureRecognizer+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (GCDelegateBlock)

@property (nonatomic, copy) BOOL (^blockForShouldBegin)(UIGestureRecognizer* gesture);
@property (nonatomic, copy) BOOL (^blockForShouldReceiveTouch)(UIGestureRecognizer* gesture, UITouch* touch);
@property (nonatomic, copy) BOOL (^blockForShouldSimultaneous)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture);

@property (nonatomic, copy) BOOL (^blockForShouldRequireFailureOf)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture);
@property (nonatomic, copy) BOOL (^blockForShouldBeRequireToFailureBy)(UIGestureRecognizer* gesture, UIGestureRecognizer* otherGesture);

- (void)usingDelegateBlocks;

@end
