//
//  RecipeFrontButton.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import "RecipeFrontButton.h"


@implementation RecipeFrontButton

- (instancetype)init
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _recipeLabel = [[UILabel alloc] init];
        _recipeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _recipeLabel.numberOfLines = 0;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings;
    NSMutableArray *_constraints;
    
    _bindings = NSDictionaryOfVariableBindings(_recipeLabel);
    
    [self addSubview:_recipeLabel];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_recipeLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_recipeLabel]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, _recipeLabel.frame.size.height + 40.0);
}

@end
