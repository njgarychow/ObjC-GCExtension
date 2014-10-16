//
//  ViewController2.h
//  MVVMDemo
//
//  Created by njgarychow on 10/16/14.
//  Copyright (c) 2014 njgarychow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController

@property (nonatomic, strong) NSString* item;

@property (nonatomic, copy) void (^dismissActionBlock)(NSDictionary* userInfo);

@end
