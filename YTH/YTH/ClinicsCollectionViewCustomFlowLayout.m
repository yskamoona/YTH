//
//  ClinicsCollectionViewCustomFlowLayout.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ClinicsCollectionViewCustomFlowLayout.h"

@implementation ClinicsCollectionViewCustomFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
 
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allAttributes = [NSMutableArray array];
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
        [allAttributes addObject:[self layoutAttributesForItemAtIndexPath:attributes.indexPath]];
    }];
    
    return  allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = [(id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    
    UICollectionViewLayoutAttributes *layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    layoutAttribute.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);

    return layoutAttribute;
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
