//
//  UICollectionView+GCDelegateAndDataSourceBlock.h
//  GCExtension
//
//  Created by njgarychow on 11/3/14.
//  Copyright (c) 2014 zhoujinqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (GCDelegateAndDataSourceBlock)

- (void)usingBlocks;

/**
 *  equal to -> |collectionView:numberOfItemsInSection:|
 */
@property (nonatomic, copy) int (^blockForItemNumber)(UICollectionView* collectionView, int section);

/**
 *  equal to -> |numberOfSectionsInCollectionView:|
 */
@property (nonatomic, copy) int (^blockForSectionNumber)(UICollectionView* collectionView);


@end
