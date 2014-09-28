//
//  RecipeListTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeListCard.h"


@interface RecipeListCard ()
{
    UIButton *_mainButton;
    UIButton *_backButton;
    NSArray *_ingredients;
    UIColor *_pattern;
}

@end

@implementation RecipeListCard


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RecipeListCard.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _pattern = [UIColor colorWithPatternImage:[UIImage imageNamed:@"card"]];
        
        /// Main Button
        _mainButton = [[UIButton alloc] init];
        _mainButton.translatesAutoresizingMaskIntoConstraints = NO;
        _mainButton.layer.shadowOffset = CGSizeMake(0, 2);
        _mainButton.layer.shadowRadius = 2;
        _mainButton.layer.shadowOpacity = 0.4;
        
        [_mainButton addTarget:self action:@selector(flip:) forControlEvents:UIControlEventTouchUpInside];
        
        [_mainButton setBackgroundColor:_pattern];
        
        _recipeLabel = [[UILabel alloc] init];
        _recipeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _recipeLabel.numberOfLines = 0;

        /// Back Button
        _backButton = [[UIButton alloc] init];
        _backButton.translatesAutoresizingMaskIntoConstraints = NO;
        _backButton.layer.shadowOffset = CGSizeMake(0, 2);
        _backButton.layer.shadowRadius = 2;
        _backButton.layer.shadowOpacity = 0.4;
        
        [_backButton addTarget:self action:@selector(flipBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [_backButton setBackgroundColor:_pattern];
        
        _ingredientsLabel = [[UILabel alloc] init];
        _ingredientsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientsLabel.numberOfLines = 0;

        [self setNeedsUpdateConstraints];
        
        self.contentView.layoutMargins = UIEdgeInsetsMake(10, 25, 10, 25);
    }
    
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings;
    NSMutableArray *_constraints;
    
    /// Main Label
    
    _bindings = NSDictionaryOfVariableBindings(_recipeLabel);
    
    [_mainButton addSubview:_recipeLabel];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_recipeLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_recipeLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [_mainButton addConstraints:_constraints];
    
    /// Back Label
    
    _bindings = NSDictionaryOfVariableBindings(_ingredientsLabel);
    
    [_backButton addSubview:_ingredientsLabel];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_ingredientsLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_ingredientsLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [_backButton addConstraints:_constraints];
    
    /// Buttons
    
    _bindings = NSDictionaryOfVariableBindings(_mainButton, _backButton);
    
    [self.contentView addSubview:_backButton];
    [self.contentView addSubview:_mainButton];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_backButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_backButton]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}

- (void)flip:(UIButton *)sender
{
    _backButton.hidden = NO;
    [UIView transitionFromView:_mainButton toView:_backButton duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        [self setNeedsUpdateConstraints];
        _mainButton.hidden = YES;
    }];
}

- (void)flipBack:(UIButton *)sender
{
    _mainButton.hidden = NO;
    [UIView transitionFromView:_backButton toView:_mainButton duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [self setNeedsUpdateConstraints];
        _backButton.hidden = YES;
    }];
}

@end
