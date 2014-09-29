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
    NSArray *_steps;
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
        
        [_mainButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_mainButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_mainButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside];
        
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
        
        [_backButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_backButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside];
        
        [_backButton setBackgroundColor:_pattern];
        
        UIFont *labelFont = [UIFont systemFontOfSize:12.0];
        
        _ingredientsLabel = [[UILabel alloc] init];
        _ingredientsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientsLabel.numberOfLines = 0;
        _ingredientsLabel.font = labelFont;
        
        _stepsLabel = [[UILabel alloc] init];
        _stepsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stepsLabel.numberOfLines = 0;
        _stepsLabel.font = labelFont;
        
        _ingredientsHeader = [[UILabel alloc] init];
        _ingredientsHeader.translatesAutoresizingMaskIntoConstraints = NO;
        
        _stepsHeader = [[UILabel alloc] init];
        _stepsHeader.translatesAutoresizingMaskIntoConstraints = NO;
        
        _backButton.hidden = YES;

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
    
    _bindings = NSDictionaryOfVariableBindings(_ingredientsLabel, _ingredientsHeader, _stepsLabel, _stepsHeader);
    
    [_backButton addSubview:_ingredientsLabel];
    [_backButton addSubview:_ingredientsHeader];
    [_backButton addSubview:_stepsLabel];
    [_backButton addSubview:_stepsHeader];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10@50)-[_ingredientsHeader]-[_ingredientsLabel]" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(10@50)-[_stepsHeader]-[_stepsLabel]" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ingredientsHeader]-[_stepsHeader]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ingredientsLabel]-[_stepsLabel]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_ingredientsHeader(==_stepsHeader)]" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[_ingredientsLabel(==_stepsLabel)]" options:0 metrics:nil views:_bindings]];
    
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

- (void)touchDown:(UIButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        sender.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
    }];
}

- (void)touchUp:(UIButton *)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         sender.layer.transform = CATransform3DIdentity;
                         
                         UIViewAnimationOptions option = UIViewAnimationOptionTransitionNone;
                         UIButton *destination;
                         
                         if (sender == _mainButton)
                         {
                             option = UIViewAnimationOptionTransitionFlipFromRight;
                             destination = _backButton;
                         }
                         else if (sender == _backButton)
                         {
                             option = UIViewAnimationOptionTransitionFlipFromLeft;
                             destination = _mainButton;
                         }
                         
                         if (sender && destination)
                         {
                             destination.hidden = NO;
                             
                             [UIView transitionFromView:sender toView:destination duration:0.5 options:option completion:^(BOOL finished) {
                                 [self setNeedsUpdateConstraints];
                                 sender.hidden = YES;
                             }];
                         }

                     }
                     completion:nil
     ];
}


@end
