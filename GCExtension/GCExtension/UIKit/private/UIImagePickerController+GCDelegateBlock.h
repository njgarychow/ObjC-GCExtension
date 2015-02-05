//
//  UIImagePickerController+GCDelegateBlock.h
//  GCExtension
//
//  Created by zhoujinqiang on 15/2/5.
//  Copyright (c) 2015年 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (GCDelegateBlock)

- (void)usingBlocks;

/**
 *  equal to -> |imagePickerController:didFinishPickingMediaWithInfo:|
 */
@property (nonatomic, copy) void (^blockForDidFinishPickingMedia)(UIImagePickerController* picker, NSDictionary* info);

/**
 *  equal to -> |imagePickerControllerDidCancel:|
 */
@property (nonatomic, copy) void (^blockForDidCancel)(UIImagePickerController* picker);

@end
