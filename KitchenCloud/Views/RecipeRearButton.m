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

-(instancetype)init
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _ingredientsTableView = [[UITableView alloc] init];
        _ingredientsTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientsTableView.delegate = self;
        _ingredientsTableView.dataSource = self;
        _ingredientsTableView.estimatedRowHeight = 20;
        _ingredientsTableView.rowHeight = UITableViewAutomaticDimension;
        _ingredientsTableView.backgroundColor = [UIColor clearColor];
        _ingredientsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _ingredientsTableView.bounces = NO;
        
        [_ingredientsTableView registerClass:IngredientCell.class forCellReuseIdentifier:NSStringFromClass(IngredientCell.class)];
    }
    
    return self;
}

- (void)updateConstraints
{
    CGSize contentSize = _ingredientsTableView.contentSize;
    
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_ingredientsTableView);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self addSubview:_ingredientsTableView];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ingredientsTableView(==height)]" options:0 metrics:@{@"height":[NSNumber numberWithFloat:contentSize.height]} views:_bindings]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(22@999)-[_ingredientsTableView]-(22@999)-|" options:0 metrics:nil views:_bindings]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[_ingredientsTableView]-(20)-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    CGFloat offset = (self.bounds.size.height - _ingredientsTableView.bounds.size.height) / 2;
    
    [_ingredientsTableView setContentOffset:CGPointMake(0, offset)];
    
    [super updateConstraints];
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
    NSInteger row = indexPath.row;
    
    IngredientCell *cell = (IngredientCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(IngredientCell.class) forIndexPath:indexPath];
    
    cell.ingredient.text = [_ingredients objectAtIndex:row];
    cell.quantity.text = [_quantities objectAtIndex:row];
    
    return cell;
}

#pragma mark - Table View Delegate
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///
}

@end
