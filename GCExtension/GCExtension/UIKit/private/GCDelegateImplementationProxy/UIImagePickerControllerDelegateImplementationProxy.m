//
//  UIImagePickerControllerDelegateImplementationProxy.m
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import "UIImagePickerControllerDelegateImplementationProxy.h"
#import "UIImagePickerController+GCDelegateBlock.h"


@interface UIImagePickerControllerDelegateImplementation : UINavigationControllerDelegateImplementation <UIImagePickerControllerDelegate>

@end

@implementation UIImagePickerControllerDelegateImplementation

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    picker.blockForDidFinishPickingMedia(picker, info);
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    picker.blockForDidCancel(picker);
}

@end









@interface UIImagePickerControllerDelegateImplementationProxy ()

@property (nonatomic, strong) UIImagePickerControllerDelegateImplementation* realObject;

@end


@implementation UIImagePickerControllerDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UIImagePickerControllerDelegateImplementation alloc] init];
    return self;
}

#define BlockStatementTest(statement) do { if (statement) { return YES; } } while (0)
#define Statement(selectorString, block) (block && [selectorString isEqualToString:targetSelectorString])
#define BlockStatement(block, selectorString) BlockStatementTest(Statement(selectorString, block))

- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString* targetSelectorString = NSStringFromSelector(aSelector);
    
    /**
     *  BlcokStatement expand:
     *  if (|block| && [|selectorString| isEqualToString:targetSelectorString]) {
     *      return YES;
     *  }
     */
    BlockStatement(self.owner.blockForDidFinishPickingMedia, @"imagePickerController:didFinishPickingMediaWithInfo:");
    BlockStatement(self.owner.blockForDidCancel, @"imagePickerControllerDidCancel:");
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_realObject methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:_realObject];
}

- (void)dealloc {
    if (self == self.owner.delegate) {
        self.owner.delegate = nil;
    }
}

@end
