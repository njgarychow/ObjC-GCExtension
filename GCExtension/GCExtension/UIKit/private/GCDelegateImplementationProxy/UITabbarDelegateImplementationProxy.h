//
//  UITabbarDelegateImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabbarDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UITabBar* owner;

- (id)init;

@end
