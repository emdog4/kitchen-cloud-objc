//
//  RecipeDetailCollectionViewFlowLayout.m
//  KitchenCloud
//
//  Created by Emery Clark on 10/5/14.
//
//

#import "RecipeDetailCollectionViewFlowLayout.h"

@implementation RecipeDetailCollectionViewFlowLayout

- (UICollectionViewScrollDirection)scrollDirection
{
    return UICollectionViewScrollDirectionVertical;
}

- (void)prepareLayout
{
    [super prepareLayout];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [super layoutAttributesForElementsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [super layoutAttributesForItemAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return [super shouldInvalidateLayoutForBoundsChange:newBounds];
}

@end
