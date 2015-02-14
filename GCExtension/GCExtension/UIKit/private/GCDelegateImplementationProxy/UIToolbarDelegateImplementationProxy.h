//
//  UIToolbarDelegateImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbarDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UIToolbar* owner;

- (id)init;

@end
