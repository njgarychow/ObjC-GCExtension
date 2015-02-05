//
//  UINavigationControllerDelegateImplementionProxy.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationControllerDelegateImplementation : NSObject <UINavigationControllerDelegate>

@end






@interface UINavigationControllerDelegateImplementionProxy : NSProxy

@property (nonatomic, weak) UINavigationController* owner;

- (id)init;

@end
