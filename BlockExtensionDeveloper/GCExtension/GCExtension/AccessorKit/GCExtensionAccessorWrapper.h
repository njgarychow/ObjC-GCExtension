//
//  GCExtensionAccessorWrapper.h
//  GCExtension
//
//  Created by zhoujinqiang on 14-9-10.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCExtensionAccessorWrapper : NSObject

@property (nonatomic, strong) id nonatomic_strong_property;
@property (nonatomic, weak) id nonatomic_weak_property;
@property (nonatomic, copy) id nonatomic_copy_property;
@property (atomic, strong) id atomic_strong_property;
@property (atomic, weak) id atomic_weak_property;
@property (atomic, copy) id atomic_copy_property;

@end
