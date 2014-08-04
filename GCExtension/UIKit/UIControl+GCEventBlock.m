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
    
    [[self _eventActionBlocksForControlEvents:event] addObject:wrapper];
}

- (void)removeAllControlEventsAction:(UIControlEvents)event {
    [[self _eventActionBlocksForControlEvents:event] removeAllObjects];
}


#pragma mark - instance private method

#pragma mark - storage the blocks of the events.
- (NSMutableArray *)_eventActionBlocksForControlEvents:(UIControlEvents)event {
    NSString* stringName = [self _stringNameForControlEvents:event];
    return [self _eventActionBlocksForControlEventsStringName:stringName];
}
- (NSMutableArray *)_eventActionBlocksForControlEventsStringName:(NSString *)stringName {
    static char const eventActionBlocksDicKey;
    NSMutableDictionary* blocksDic = objc_getAssociatedObject(self, &eventActionBlocksDicKey);
    if (!blocksDic) {
        blocksDic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &eventActionBlocksDicKey, blocksDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    NSMutableArray* blocksArr = blocksDic[stringName];
    if (!blocksArr) {
        blocksArr = [NSMutableArray array];
        blocksDic[stringName] = blocksArr;
    }
    
    return blocksArr;
}
- (NSString *)_stringNameForControlEvents:(UIControlEvents)event {
    return [NSString stringWithFormat:@"method_avoid_conflict_placeholder_%@_target:touches:", @(event)];
}



@end
