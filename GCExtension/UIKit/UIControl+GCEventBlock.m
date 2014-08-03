//
//  UIControl+GCEventBlock.m
//  GCExtension
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "UIControl+GCEventBlock.h"

#import <objc/runtime.h>



@implementation UIControl (GCEventBlock)

- (void)addControlEvents:(UIControlEvents)event action:(GCEventActionBlock)action {
    
    if (!action) {
        return;
    }
    
    SEL selector = [self _selectorForControlEvents:event];
    if (![self respondsToSelector:selector]) {
        class_addMethod([self class], selector, (IMP)_eventActionHandler, "v@:@@");
        [self addTarget:self action:selector forControlEvents:event];
    }
    
    [[self _eventActionBlocksForControlEvents:event] addObject:action];
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

#pragma mark - the IMP of the event's action handler.
void _eventActionHandler(id self, SEL _cmd, id target, id touchEvent) {
    NSString* stringName = [self _stringNameForControlEventsFromSelector:_cmd];
    for (GCEventActionBlock block in [self _eventActionBlocksForControlEventsStringName:stringName]) {
        block(target, [touchEvent allTouches]);
    }
}

#pragma mark - |stringName|, |selector|, |event| convert to each other.
- (SEL)_selectorForControlEvents:(UIControlEvents)event {
    NSString* selectorNameString = [self _stringNameForControlEvents:event];
    return sel_registerName([selectorNameString cStringUsingEncoding:NSUTF8StringEncoding]);
}
- (NSString *)_stringNameForControlEventsFromSelector:(SEL)selector {
    return [NSString stringWithCString:sel_getName(selector) encoding:NSUTF8StringEncoding];
}
- (NSString *)_stringNameForControlEvents:(UIControlEvents)event {
    return [NSString stringWithFormat:@"method_avoid_conflict_placeholder_%@_target:touches:", @(event)];
}



@end
