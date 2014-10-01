//
//  RecipeCollectionViewCell.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import <UIKit/UIKit.h>

#import "RecipeCVCFrontView.h"
#import "RecipeCVCRearView.h"

@interface RecipeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) RecipeCVCFrontView *frontView;
@property (strong, nonatomic) RecipeCVCRearView *rearView;

@end
