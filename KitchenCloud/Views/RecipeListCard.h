//
//  RecipeListCard.h
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecipeFrontButton.h"
#import "RecipeRearButton.h"

@interface RecipeListCard : UITableViewCell

@property (strong, nonatomic) RecipeFrontButton *frontButton;
@property (strong, nonatomic) RecipeRearButton *rearButton;

@end
