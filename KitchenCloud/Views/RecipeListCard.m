//
//  RecipeListTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeListCard.h"

@implementation RecipeListCard

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RecipeListCard.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _frontButton = [[RecipeFrontButton alloc] init];
        _frontButton.parentCell = self;
        
        _rearButton = [[RecipeRearButton alloc] init];
        _rearButton.hidden = YES;
        _rearButton.parentCell = self;

        _frontButton.oppositeSideButton = _rearButton;
        _rearButton.oppositeSideButton = _frontButton;
        
        self.contentView.layoutMargins = UIEdgeInsetsMake(10, 25, 10, 25);
    }
    
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings;
    NSMutableArray *_constraints;
    
    /// Buttons
    
    _bindings = NSDictionaryOfVariableBindings(_frontButton, _rearButton);
    
    [self.contentView addSubview:_rearButton];
    [self.contentView addSubview:_frontButton];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_frontButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_frontButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_rearButton]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_rearButton]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}

@end
