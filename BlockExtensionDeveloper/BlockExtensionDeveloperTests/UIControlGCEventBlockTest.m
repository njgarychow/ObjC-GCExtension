//
//  BlockExtensionDeveloperTests.m
//  BlockExtensionDeveloperTests
//
//  Created by njgarychow on 14-8-3.
//  Copyright (c) 2014年 zhoujinqiang. All rights reserved.
//

#import "Kiwi.h"

#import "GCExtension.h"



SPEC_BEGIN(GC_UIControl_GCEventBlock_Test)

describe(@"UIControl GCEventBlock", ^{
    
    context(@"when using blocks", ^{
        
        let(button, ^id{
            return [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
        });
        let(window, ^id{
            return [[[UIApplication sharedApplication] delegate] window];
        });
        
        beforeEach(^{
            [window addSubview:button];
        });
        
        it(@"does button add control event working ...", ^{
            __block BOOL isBlockInvoked = NO;
            [button addControlEvents:UIControlEventTouchUpInside
                              action:^(UIControl *control, NSSet *touches) {
                                  isBlockInvoked = YES;
                              }];
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
            [[theValue(isBlockInvoked) should] equal:theValue(YES)];
        });
        
        it(@"does button add control event block parameters right ...", ^{
            __weak typeof(button) weakButton = button;
            [button addControlEvents:UIControlEventTouchUpInside
                              action:^(UIControl *control, NSSet *touches) {
                                  [[control should] equal:weakButton];
                              }];
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        });
        
        it(@"does button remove block working ...", ^{
            [button addControlEvents:UIControlEventTouchUpInside
                              action:^(UIControl *control, NSSet *touches) {
                                  fail(@"should not invoke this block ..., the remove method is not working.");
                              }];
            [button removeAllControlEventsAction:UIControlEventTouchUpInside];
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        });
    });
});


SPEC_END
