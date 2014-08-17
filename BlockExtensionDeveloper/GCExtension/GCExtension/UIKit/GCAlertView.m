//
//  GCAlertView.m
//  GCExtension
//
//  Created by njgarychow on 14-8-18.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "GCAlertView.h"

#import "GCMacro.h"



@interface GCAlertViewActionBlockWrapper : NSObject

@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) void (^actionBlock)();

- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock;

@end

@implementation GCAlertViewActionBlockWrapper

- (instancetype)initWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock {
    if (self = [self init]) {
        _title = title;
        _actionBlock = actionBlock;
    }
    return self;
}

@end





@interface GCAlertView () <UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView* alertView;

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* message;

@property (nonatomic, strong) GCAlertViewActionBlockWrapper* cancelWrapper;
@property (nonatomic, strong) NSMutableArray* otherWrappers;

@end

@implementation GCAlertView

- (id)initWithFrame:(CGRect)frame {
    NSAssert(NO, @"use |initWithTitle:message:| instead.");
    return nil;
}

- (instancetype)initWithTitle:(NSString *)title andMessage:(NSString *)message {
    if (self = [super initWithFrame:CGRectZero]) {
        _title = title;
        _message = message;
        
        _otherWrappers = [NSMutableArray array];
    }
    return self;
}

- (void)setCancelButtonWithTitle:(NSString *)cancelTitle actionBlock:(void (^)())cancelBlock {
    _cancelWrapper = [[GCAlertViewActionBlockWrapper alloc] initWithTitle:cancelTitle actionBlock:cancelBlock];
}

- (void)addOtherButtonWithTitle:(NSString *)otherTitle actionBlock:(void (^)())otherBlock {
    GCAlertViewActionBlockWrapper* wrapper = [[GCAlertViewActionBlockWrapper alloc]
                                              initWithTitle:otherTitle actionBlock:otherBlock];
    [_otherWrappers addObject:wrapper];
}

- (void)show {
    
    CFTypeRef cf_self = (__bridge CFTypeRef)(self);
    CFRetain(cf_self);
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:_title
                                                    message:_message
                                                   delegate:self
                                          cancelButtonTitle:_cancelWrapper.title
                                          otherButtonTitles:nil];
    for (GCAlertViewActionBlockWrapper* action in _otherWrappers) {
        [alert addButtonWithTitle:action.title];
    }
    [alert show];
}

#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView cancelButtonIndex] == buttonIndex) {
        GCBlockInvoke(_cancelWrapper.actionBlock);
    }
    else {
        GCAlertViewActionBlockWrapper* actionWrapper = _otherWrappers[buttonIndex-1];
        GCBlockInvoke(actionWrapper.actionBlock);
    }
    
    CFTypeRef cf_self = (__bridge CFTypeRef)(self);
    CFRelease(cf_self);
}

@end
