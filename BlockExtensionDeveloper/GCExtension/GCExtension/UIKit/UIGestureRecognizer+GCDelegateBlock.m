//
//  UIGestureRecognizer+GCDelegateBlock.m
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIGestureRecognizer+GCDelegateBlock.h"

#import "GCMacro.h"
#import "NSObject+GCAccessor.h"



@interface UIGestureRecognizerDelegateImplement : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIGestureRecognizer* owner;

@end

@implementation UIGestureRecognizerDelegateImplement

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL should = YES;
    if (self.owner.blockForShouldBegin) {
        should = self.owner.blockForShouldBegin();
    }
    return should;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    BOOL should = YES;
    if (self.owner.blockForShouldReceiveTouch) {
        should = self.owner.blockForShouldReceiveTouch(touch);
    }
    return should;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL should = NO;
    if (self.owner.blockForShouldSimultaneous) {
        should = self.owner.blockForShouldSimultaneous(otherGestureRecognizer);
    }
    return should;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL should = NO;
    if (self.owner.blockForShouldBeRequireToFailureBy) {
        should = self.owner.blockForShouldBeRequireToFailureBy(otherGestureRecognizer);
    }
    return should;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    BOOL should = NO;
    if (self.owner.blockForShouldRequireFailureOf) {
        should = self.owner.blockForShouldRequireFailureOf(otherGestureRecognizer);
    }
    return should;
}

@end










@interface UIGestureRecognizer (GCDelegateBlockProperty)
@property (nonatomic, strong) UIGestureRecognizerDelegateImplement* implement;
@end

@implementation UIGestureRecognizer (GCDelegateBlockProperty)
@dynamic implement;
@end


@implementation UIGestureRecognizer (GCDelegateBlock)

- (void)usingDelegateBlocks {
    if (!self.implement) {
        self.implement = [[UIGestureRecognizerDelegateImplement alloc] init];
        self.implement.owner = self;
    }
    self.delegate = self.implement;
}


@dynamic blockForShouldBegin;
@dynamic blockForShouldReceiveTouch;
@dynamic blockForShouldSimultaneous;
@dynamic blockForShouldRequireFailureOf;
@dynamic blockForShouldBeRequireToFailureBy;


+ (void)load {
    [self extensionAccessorGenerator];
}

+ (NSArray *)extensionAccessorNonatomicCopyPropertyNames {
    return @[@"blockForShouldBegin",
             @"blockForShouldReceiveTouch",
             @"blockForShouldSimultaneous",
             @"blockForShouldRequireFailureOf",
             @"blockForShouldBeRequireToFailureBy"];
}

+ (NSArray *)extensionAccessorNonatomicStrongPropertyNames {
    return @[@"implement"];
}

@end
