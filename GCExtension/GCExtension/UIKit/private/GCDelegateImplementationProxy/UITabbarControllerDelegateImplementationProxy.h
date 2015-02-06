//
//  UITabbarControllerDelegateImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/6/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabbarControllerDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UITabBarController* owner;

- (id)init;

@end
