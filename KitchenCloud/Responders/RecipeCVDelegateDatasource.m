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
                     @"spicy thai noodles",@"dinner for breakfast", @"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
                     @"creamy pesto pasta with vegan alfredo sauce and vegan banana and strawberry ice cream for desert",
                     @"spicy thai noodles",@"dinner for breakfast", @"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
                     @"creamy pesto pasta with vegan alfredo sauce and vegan banana and strawberry ice cream for desert",
                     @"spicy thai noodles",@"dinner for breakfast", @"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
                     @"creamy pesto pasta with vegan alfredo sauce and vegan banana and strawberry ice cream for desert",
                     @"spicy thai noodles",@"dinner for breakfast", @"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
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
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    RecipeCollectionViewCell *cell = (RecipeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(RecipeCollectionViewCell.class) forIndexPath:indexPath];
    
    cell.frontView.recipeLabel.text = [_recipes objectAtIndex:indexPath.row];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(400, 150);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *recipe = [_recipes objectAtIndex:indexPath.row];
    

}

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

- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
