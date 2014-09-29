//
//  RecipeListCard.h
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeListCard : UITableViewCell

@property (strong, nonatomic) UILabel *recipeLabel;
@property (strong, nonatomic) UILabel *ingredientsLabel;
@property (strong, nonatomic) UILabel *stepsLabel;
@property (strong, nonatomic) UILabel *ingredientsHeader;
@property (strong, nonatomic) UILabel *stepsHeader;
@end
