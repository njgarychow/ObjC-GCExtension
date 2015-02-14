//
//  UINavigationBarDelegateImpletationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBarDelegateImpletationProxy : NSProxy

@property (nonatomic, weak) UINavigationBar* owner;

- (id)init;

@end
