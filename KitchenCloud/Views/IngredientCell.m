//
//  IngredientCell.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/29/14.
//
//

#import "IngredientCell.h"

@implementation IngredientCell

static NSString *ReuseCellId = @"ReuseCellId";

-(instancetype)initWithIngredient:(NSString *)ingredient andQuantity:(NSString *)quantity
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseCellId])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ingredient = [[UILabel alloc] init];
        _ingredient.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredient.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _ingredient.text = ingredient;
        [_ingredient sizeToFit];
        
        _quantity = [[UILabel alloc] init];
        _quantity.translatesAutoresizingMaskIntoConstraints = NO;
        _quantity.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _quantity.text = quantity;
        [_quantity sizeToFit];
        
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithIngredient:@"none" andQuantity:@"none"];
}

- (void)updateConstraints
{
    NSDictionary *_bindings;
    NSMutableArray *_constraints;
    
    _bindings = NSDictionaryOfVariableBindings(_ingredient, _quantity);
    
    [self.contentView addSubview:_ingredient];
    [self.contentView addSubview:_quantity];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_ingredient]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_quantity]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ingredient]-[_quantity]-|" options:0 metrics:nil views:_bindings]];
//    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_recipeLabel]" options:0 metrics:nil views:_bindings]];
//    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_quantity]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, _ingredient.frame.size.height);
}

@end
