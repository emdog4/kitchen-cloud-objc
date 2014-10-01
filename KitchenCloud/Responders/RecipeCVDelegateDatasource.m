//
//  RecipeCVDelegateDatasource.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCVDelegateDatasource.h"
#import "RecipeCollectionViewCell.h"

#import "RecipeCVCFrontView.h"
#import "RecipeCVCRearView.h"

@interface RecipeCVDelegateDatasource ()
{
    NSArray *_recipes;
}
@end

@implementation RecipeCVDelegateDatasource

- (instancetype)init
{
    if (self = [super init])
    {
        _recipes = @[@"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
                            @"creamy pesto pasta with vegan alfredo sauce and vegan banana and strawberry ice cream for desert",
                            @"spicy thai noodles",@"dinner for breakfast"];
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
    return [_recipes count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeCollectionViewCell *cell = (RecipeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RecipeCollectionViewCell.class) forIndexPath:indexPath];
    
    cell.frontView = [[RecipeCVCFrontView alloc] init];
    cell.frontView.recipeLabel.text = [_recipes objectAtIndex:indexPath.row];
    
    [cell.frontView setNeedsUpdateConstraints];
    [cell.frontView updateConstraintsIfNeeded];
    
    cell.rearView = [[RecipeCVCRearView alloc] init];
    
    [cell.rearView setNeedsUpdateConstraints];
    [cell.rearView updateConstraintsIfNeeded];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(400, 150);
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
