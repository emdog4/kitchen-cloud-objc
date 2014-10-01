//
//  RecipeCVCFrontView.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCVCFrontView.h"

@interface RecipeCVCFrontView ()
{
    UILabel *_recipeLabel;
}

@end

@implementation RecipeCVCFrontView

- (instancetype)init
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _recipeLabel = [[UILabel alloc] init];
        _recipeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _recipeLabel.numberOfLines = 0;
    }
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_recipeLabel);

    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self addSubview:_recipeLabel];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_recipeLabel]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_recipeLabel]-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    [super updateConstraints];
}


- (void)setRecipeLabel:(UILabel *)recipeLabel
{
    _recipeLabel = recipeLabel;
    _recipeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    [_recipeLabel sizeToFit];
    [_recipeLabel invalidateIntrinsicContentSize];
    [self setNeedsUpdateConstraints];
}

@end
