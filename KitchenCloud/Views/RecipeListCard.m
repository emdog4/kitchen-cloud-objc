//
//  RecipeListTableViewCell.m
//  RecipeHelper
//
//  Created by emdog4 on 7/9/14.
//  Copyright (c) 2014 Emery Clark. All rights reserved.
//

#import "RecipeListCard.h"

@implementation RecipeListCard


- (instancetype)initWithFront:(RecipeFrontButton *)front andRear:(RecipeRearButton *)rear
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RecipeListCard.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        
        _frontButton = front;

        _rearButton = rear;
        _rearButton.hidden = YES;
        
        _frontButton.parentCell = self;
        _rearButton.parentCell = self;
        
        _frontButton.oppositeSideButton = _rearButton;
        _rearButton.oppositeSideButton = _frontButton;
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
        
        self.contentView.layoutMargins = UIEdgeInsetsMake(10, 25, 10, 25);
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"name"];
    
    RecipeFrontButton *frontButton = [[RecipeFrontButton alloc] initWithAttributedString:attrString];
    RecipeRearButton *rearButton = [[RecipeRearButton alloc] initWithArray:@[@"none"] andArray:@[@"none"]];
    
    return [self initWithFront:frontButton andRear:rearButton];
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

- (CGSize)intrinsicContentSize
{
    return [_frontButton intrinsicContentSize];
}

@end
