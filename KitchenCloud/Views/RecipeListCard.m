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
}

@end

@implementation RecipeListCard


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RecipeListCard.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _mainButton = [[UIButton alloc] init];
        _mainButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        _mainButton.layer.shadowOffset = CGSizeMake(0, 2);
        _mainButton.layer.shadowRadius = 2;
        _mainButton.layer.shadowOpacity = 0.4;

        UIColor *pattern = [UIColor colorWithPatternImage:[UIImage imageNamed:@"card"]];

        [_mainButton setBackgroundColor:pattern];
        
        _recipeName = [[UILabel alloc] init];
        _recipeName.translatesAutoresizingMaskIntoConstraints = NO;
        _recipeName.numberOfLines = 0;
        
        NSDictionary *_bindings = NSDictionaryOfVariableBindings(_recipeName);
        
        [_mainButton addSubview:_recipeName];
        
        NSMutableArray *_constraints = [NSMutableArray array];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[_recipeName]-(20)-|" options:0 metrics:nil views:_bindings]];

        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_recipeName]-(20)-|" options:0 metrics:nil views:_bindings]];
        
        [_mainButton addConstraints:_constraints];
        
        
        _bindings = NSDictionaryOfVariableBindings(_mainButton);
        
        [self.contentView addSubview:_mainButton];
        
        _constraints = [NSMutableArray array];
        
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];
        [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_mainButton]-|" options:0 metrics:nil views:_bindings]];

        [self.contentView addConstraints:_constraints];
        
        self.contentView.layoutMargins = UIEdgeInsetsMake(10, 25, 10, 25);

    }
    
    return self;
}

@end
