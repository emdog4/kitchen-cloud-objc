//
//  RecipeCVRearCVDelegateDatasource.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCVRearCVDelegateDatasource.h"
#import "RecipeCVCRearCollectionViewCell.h"

@interface RecipeCVRearCVDelegateDatasource ()
{
    NSArray *_ingredients;
    NSArray *_quantities;
}
@end

@implementation RecipeCVRearCVDelegateDatasource

- (instancetype)init
{
    if (self = [super init])
    {
        _ingredients = @[@"spaghetti",
                         @"earth balance",
                         @"garlic minced",
                         @"spinach",
                         @"chopped kalamata olives",
                         @"chopped dry sun-dried tomatoes",
                         @"salt and pepper"];
        
        _quantities = @[@"1 lb", [NSString stringWithFormat:@"%C cup",0x00BD], @"10 cloves", @"8oz", @"1 cup", @"1 cup", @"to taste"];
    }
    return self;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_ingredients count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeCVCRearCollectionViewCell *cell = (RecipeCVCRearCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RecipeCVCRearCollectionViewCell.class) forIndexPath:indexPath];
    
    cell.leftLabel.text = [_ingredients objectAtIndex:indexPath.row];

    cell.rightLabel.text = [_quantities objectAtIndex:indexPath.row];
    
    [cell setupLabels];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(250, 25);
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
