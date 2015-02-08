//
//  UIPickerViewDelegateImplementationProxy.m
//  GCExtension
//
//  Created by njgarychow on 2/8/15.
//  Copyright (c) 2015 zhoujinqiang. All rights reserved.
//

#import "UIPickerViewDelegateImplementationProxy.h"
#import "UIPickerView+GCDelegateAndDataSourceBlock.h"

@interface UIPickerViewDelegateImplementation : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

@end

@implementation UIPickerViewDelegateImplementation

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.blockForWidthForComponent(pickerView, component);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return pickerView.blockForRowHeightForComponent(pickerView, component);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerView.blockForTitltForRowForComponent(pickerView, row, component);
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerView.blockForAttributedTitleForRowForComponent(pickerView, row, component);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    return pickerView.blockForViewForRowForComponentWithReusingView(pickerView, row, component, view);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    pickerView.blockForDidSelectRowInComponent(pickerView, row, component);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return pickerView.blockForNumberOfComponents(pickerView);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerView.blockForNumberOfRowsInComponent(pickerView, component);
}

@end









@interface UIPickerViewDelegateImplementationProxy ()

@property (nonatomic, strong) UIPickerViewDelegateImplementation* realObject;

@end

@implementation UIPickerViewDelegateImplementationProxy

- (instancetype)init {
    _realObject = [[UIPickerViewDelegateImplementation alloc] init];
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
    BlockStatement(self.owner.blockForRowHeightForComponent, @"pickerView:rowHeightForComponent:");
    BlockStatement(self.owner.blockForWidthForComponent, @"pickerView:widthForComponent:");
    BlockStatement(self.owner.blockForTitltForRowForComponent, @"pickerView:titleForRow:forComponent:");
    BlockStatement(self.owner.blockForAttributedTitleForRowForComponent, @"pickerView:attributedTitleForRow:forComponent:");
    BlockStatement(self.owner.blockForViewForRowForComponentWithReusingView, @"pickerView:viewForRow:forComponent:reusingView:");
    BlockStatement(self.owner.blockForDidSelectRowInComponent, @"pickerView:didSelectRow:inComponent:");
    BlockStatement(self.owner.blockForNumberOfComponents, @"numberOfComponentsInPickerView:");
    BlockStatement(self.owner.blockForNumberOfRowsInComponent, @"pickerView:numberOfRowsInComponent:");
    
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
