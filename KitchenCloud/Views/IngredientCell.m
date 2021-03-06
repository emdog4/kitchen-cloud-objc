//
//  IngredientCell.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/29/14.
//
//

#import "IngredientCell.h"

@implementation IngredientCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(IngredientCell.class)])
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ingredient = [[UILabel alloc] init];
        _ingredient.translatesAutoresizingMaskIntoConstraints = NO;
        
        _quantity = [[UILabel alloc] init];
        _quantity.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self setupDynamicType];
        
        [self.contentView setNeedsUpdateConstraints];
        [self.contentView updateConstraintsIfNeeded];
    }
    
    return self;
}

- (void)setupDynamicType
{
    UIFontDescriptor *preferredFont = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    CGFloat pointSize = [preferredFont pointSize];
    UIFont *newFont = [UIFont fontWithDescriptor:preferredFont size:pointSize-3.0];
    
    _ingredient.font = newFont;
    _quantity.font = newFont;
}

- (void)updateConstraints
{
    NSDictionary *_bindings;
    NSMutableArray *_constraints;
    
    _bindings = NSDictionaryOfVariableBindings(_ingredient, _quantity);
    
    [self.contentView addSubview:_ingredient];
    [self.contentView addSubview:_quantity];
    
    _constraints = [NSMutableArray array];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_ingredient]|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_quantity]|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ingredient]-[_quantity]-|" options:0 metrics:nil views:_bindings]];
    
    [self.contentView addConstraints:_constraints];
    
    [super updateConstraints];
}

@end
