//
//  RecipeCVCRearCollectionViewCell.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCVCRearCollectionViewCell.h"

@implementation RecipeCVCRearCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_leftLabel, _rightLabel);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self.contentView addSubview:_leftLabel];
    [self.contentView addSubview:_rightLabel];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftLabel]|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightLabel]|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_leftLabel]-[_rightLabel]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}

- (void)setupLabels
{
    _leftLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    [_leftLabel sizeToFit];
    [_leftLabel invalidateIntrinsicContentSize];
    
    _rightLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    [_rightLabel sizeToFit];
    [_rightLabel invalidateIntrinsicContentSize];
}

@end
