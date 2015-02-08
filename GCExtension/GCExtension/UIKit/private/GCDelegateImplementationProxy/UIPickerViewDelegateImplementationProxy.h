//
//  UIPickerViewDelegateImplementationProxy.h
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPickerViewDelegateImplementationProxy : NSProxy

@property (nonatomic, weak) UIPickerView* owner;

- (id)init;

@end
