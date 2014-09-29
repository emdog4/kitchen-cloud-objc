//
//  RecipeRearButton.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import "RecipeRearButton.h"

#import "IngredientCell.h"

@implementation RecipeRearButton

static NSString *ReuseId = @"CloudReuseId";


- (instancetype)initWithArray:(NSArray *)ingredients andArray:(NSArray *)quantites
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _ingredients = ingredients;
        _quantities = quantites;
        
        _ingredientsTableView = [[UITableView alloc] init];
        _ingredientsTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientsTableView.delegate = self;
        _ingredientsTableView.dataSource = self;
        _ingredientsTableView.estimatedRowHeight = 30;
        _ingredientsTableView.rowHeight = UITableViewAutomaticDimension;
        _ingredientsTableView.backgroundColor = [UIColor clearColor];
        _ingredientsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_ingredientsTableView registerClass:IngredientCell.class forCellReuseIdentifier:ReuseId];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_ingredientsTableView);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self addSubview:_ingredientsTableView];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_ingredientsTableView]-|" options:0 metrics:nil views:_bindings]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_ingredientsTableView]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return [self.oppositeSideButton intrinsicContentSize];
}

#pragma mark - Table View Datasource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_ingredients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IngredientCell *cell = [[IngredientCell alloc] initWithIngredient:[_ingredients objectAtIndex:indexPath.row] andQuantity:[_quantities objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Table View Delegate
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///
}

@end
