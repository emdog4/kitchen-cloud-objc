//
//  RecipeCollectionViewCell.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import <UIKit/UIKit.h>

#import "RecipeCVCFrontView.h"

@interface RecipeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) RecipeCVCFrontView *frontView;
@property (strong, nonatomic) UIView *editingView;
@property (strong, nonatomic) NSArray *editingV;
@property (strong, nonatomic) NSArray *frontV;
@property (strong, nonatomic) NSArray *rearV;
@property (strong, nonatomic) NSArray *frontH;
@property (strong, nonatomic) NSArray *rearH;
@property (strong, nonatomic) NSArray *frontEditingH;
@property (strong, nonatomic) NSArray *editingW;
@end
