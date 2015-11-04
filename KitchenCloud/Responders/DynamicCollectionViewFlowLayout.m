//
//  DynamicCollectionViewFlowLayout.m


#import "DynamicCollectionViewFlowLayout.h"

@implementation DynamicCollectionViewFlowLayout
{
    UIDynamicAnimator *_dynamicAnimator;
}

- (UICollectionViewScrollDirection)scrollDirection
{
    return UICollectionViewScrollDirectionVertical;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    if (!_dynamicAnimator)
    {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items)
        {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
            spring.length = 0;
            spring.damping = 0.9;
            spring.frequency = 0.8;
            
            [_dynamicAnimator addBehavior:spring];
        }
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_dynamicAnimator itemsInRect:rect];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    // bounds.origin == contentOffset
    CGFloat scrollDeltaY = newBounds.origin.y - self.collectionView.bounds.origin.y;
    CGFloat scrollDeltaX = newBounds.origin.x - self.collectionView.bounds.origin.x;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors)
    {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouchY = fabsf(touchLocation.y - anchorPoint.y);
        CGFloat distanceFromTouchX = fabsf(touchLocation.x - anchorPoint.x);
        CGFloat scrollResistenceY = distanceFromTouchY / 500;
        CGFloat scrollResistenceX = distanceFromTouchX / 500;
        
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDeltaY * scrollResistenceY;
        center.x += scrollDeltaX * scrollResistenceX;
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }
    
    return NO;
}

@end
