//
//  RecipeCollectionViewCell.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCollectionViewCell.h"

@implementation RecipeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _frontView = [[RecipeCVCFrontView alloc] init];
        _frontView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        _rearView = [[RecipeCVCRearView alloc] init];
        _rearView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_frontView, _rearView);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self.contentView addSubview:_rearView];
    [self.contentView addSubview:_frontView];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_frontView]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_frontView]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_rearView]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_rearView]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}



@end
