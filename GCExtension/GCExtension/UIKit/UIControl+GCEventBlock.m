//
//  UIControl+GCEventBlock.m
//  GCExtension
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIControl+GCEventBlock.h"

#import <objc/runtime.h>


@interface UIControlEventBlockWrapper : NSObject

@property (nonatomic, strong) GCEventActionBlock eventActionBlock;

+ (instancetype)createWrapperWithControl:(UIControl *)control
                           controlEvents:(UIControlEvents)event
                        eventActionBlock:(GCEventActionBlock)eventActionBlock;

@end

@implementation UIControlEventBlockWrapper

+ (instancetype)createWrapperWithControl:(UIControl *)control
                           controlEvents:(UIControlEvents)event
                        eventActionBlock:(GCEventActionBlock)eventActionBlock {
    return [[self alloc] initWithControl:control controlEvents:event eventActionBlock:eventActionBlock];
}
- (instancetype)initWithControl:(UIControl *)control
                  controlEvents:(UIControlEvents)event
               eventActionBlock:(GCEventActionBlock)eventActionBlock {
    if (self = [self init]) {
        [control addTarget:self action:@selector(_executeActionBlockByControl:touches:) forControlEvents:event];
        _eventActionBlock = eventActionBlock;
    }
    return self;
}

- (void)_executeActionBlockByControl:(UIControl *)control touches:(NSSet *)touches {
    _eventActionBlock(control, touches);
}

@end






@implementation UIControl (GCEventBlock)

- (void)addControlEvents:(UIControlEvents)event action:(GCEventActionBlock)action {
    NSParameterAssert(action);
    
    UIControlEventBlockWrapper* wrapper = [UIControlEventBlockWrapper
                                           createWrapperWithControl:self
                                           controlEvents:event
                                           eventActionBlock:action];
    
    [[self _controlEventsBlockWrappersForControlEvents:event] addObject:wrapper];
}

- (void)removeAllControlEventsAction:(UIControlEvents)event {
    [[self _controlEventsBlockWrappersForControlEvents:event] removeAllObjects];
}


#pragma mark - instance private method
- (NSMutableArray *)_controlEventsBlockWrappersForControlEvents:(UIControlEvents)event {
    static char const wrappersDicKey;
    NSMutableDictionary* wrapperDic = objc_getAssociatedObject(self, &wrappersDicKey);
    if (!wrapperDic) {
        wrapperDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &wrappersDicKey, wrapperDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* wrapperArr = wrapperDic[@(event)];
    if (!wrapperArr) {
        wrapperArr = [NSMutableArray array];
        wrapperDic[@(event)] = wrapperArr;
    }
    
    return wrapperArr;
}


@end
