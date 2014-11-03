//
//  UICollectionViewDelegateAndDataSourceImplementProxy.m
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import "UICollectionViewDelegateAndDataSourceImplementationProxy.h"

#import "UICollectionView+GCDelegateAndDataSourceBlock.h"


@interface UICollectionViewDelegateAndDataSourceImplementation : UIScrollViewDelegateImplementation <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@end

@implementation UICollectionViewDelegateAndDataSourceImplementation

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return collectionView.blockForItemNumber(collectionView, (int)section);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return collectionView.blockForSectionNumber(collectionView);
}

@end







@interface UICollectionViewDelegateAndDataSourceImplementationProxy ()

@property (nonatomic, strong) UICollectionViewDelegateAndDataSourceImplementation* realObject;

@end

@implementation UICollectionViewDelegateAndDataSourceImplementationProxy

- (instancetype)init {
    _realObject = [[UICollectionViewDelegateAndDataSourceImplementation alloc] init];
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
    BlockStatement(self.owner.blockForItemNumber, @"collectionView:numberOfItemsInSection:");
    BlockStatement(self.owner.blockForSectionNumber, @"numberOfSectionsInCollectionView:");
    
    
    return [super respondsToSelector:aSelector];
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
    if (self == self.owner.dataSource) {
        self.owner.dataSource = nil;
    }
}

@end
