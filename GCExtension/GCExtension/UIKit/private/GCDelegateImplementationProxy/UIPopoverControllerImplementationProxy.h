//
//  UIPopoverControllerImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/14/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPopoverControllerImplementationProxy : NSProxy

@property (nonatomic, weak) UIPopoverController* owner;

- (id)init;

@end
