//
//  RecipeRearButton.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import <UIKit/UIKit.h>
#import "CloudFlipButton.h"

@interface RecipeRearButton : CloudFlipButton <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSArray *quantities;
@property (strong, nonatomic) UITableView *ingredientsTableView;

- (instancetype)initWithArray:(NSArray *)ingredients andArray:(NSArray *)quantites;

@end
