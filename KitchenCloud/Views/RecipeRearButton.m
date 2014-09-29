//
//  RecipeRearButton.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import "RecipeRearButton.h"


@implementation RecipeRearButton

static NSString *ReuseId = @"CloudReuseId";


- (instancetype)initWithArray:(NSArray *)ingredients andArray:(NSArray *)quantites
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _ingredients = ingredients;
        _quantities = quantites;
        
        _ingredientsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        _ingredientsTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _ingredientsTableView.delegate = self;
        _ingredientsTableView.dataSource = self;
        _ingredientsTableView.estimatedRowHeight = 100;
        _ingredientsTableView.rowHeight = UITableViewAutomaticDimension;
        _ingredientsTableView.backgroundColor = [UIColor clearColor];
        _ingredientsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_ingredientsTableView registerClass:UITableViewCell.class forCellReuseIdentifier:ReuseId];
        
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
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_ingredientsTableView]-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    [super updateConstraints];
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(UIViewNoIntrinsicMetric, 150.0);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text = [_ingredients objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_quantities objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table View Datasource
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///
}

@end
