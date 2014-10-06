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
        
        _editingView = [[UIView alloc] init];
        _editingView.backgroundColor = [UIColor redColor];
        _editingView.translatesAutoresizingMaskIntoConstraints = NO;

        [self.contentView addSubview:_rearView];
        [self.contentView addSubview:_frontView];
    }
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_frontView, _rearView, _editingView);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    _frontV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_frontView]|" options:0 metrics:nil views:_bindings];
    [_constraints addObjectsFromArray:_frontV];
    
    if ([_editingView superview])
    {
        _editingV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_editingView]|" options:0 metrics:nil views:_bindings];
        [_constraints addObjectsFromArray:_editingV];
        _frontEditingH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_frontView]-[_editingView]|" options:0 metrics:nil views:_bindings];
        [_constraints addObjectsFromArray:_frontEditingH];
    }
    else
    {
        _rearV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rearView]|" options:0 metrics:nil views:_bindings];
        [_constraints addObjectsFromArray:_rearV];
        _frontH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_frontView]|" options:0 metrics:nil views:_bindings];
        [_constraints addObjectsFromArray:_frontH];
        _rearH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_rearView]|" options:0 metrics:nil views:_bindings];
        [_constraints addObjectsFromArray:_rearH];
    }
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}



@end
