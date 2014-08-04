//
//  UIControl+GCEventBlock.h
//  GCExtension
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GCEventActionBlock)(UIControl* control, NSSet* touches);

@interface UIControl (GCEventBlock)

- (void)addControlEvents:(UIControlEvents)event action:(GCEventActionBlock)action;
- (void)removeAllControlEventsAction:(UIControlEvents)event;

@end
