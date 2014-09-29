//
//  RecipeListViewController.m
//  ReceipePro
//
//  Created by Emery Clark on 7/7/13.
//  Copyright (c) 2013 Emery Clark. All rights reserved.
//

#import "RecipeListViewController.h"

#import "RecipeDetailViewController.h"
#import "EmptyRecipeViewController.h"

#import "RecipeListCard.h"

#import "RecipeTextViewController.h"

#import "Models.h"


@interface RecipeListViewController ()
{
    UISearchController *_searchController;
    
    UITableView *_searchResultsTableView;
    UITableView *_mainTableView;

    NSArray *_dataAllRecipes;
    NSArray *_dataSearchedRecipes;
    NSArray *_ingredients;
    NSArray *_steps;
    
    NSManagedObjectContext *_context;
    
    RecipeTextViewController *_recipeTextVC;
    
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}
@end


@implementation RecipeListViewController

static NSString *ReuseableTableViewCellId = @"ReuseableTableViewCellId";

- (instancetype)init
{
    if (self = [super init])
    {
        self.title = NSLocalizedString(@"All Recipes", @"All Recipes");
        
        _ingredients = @[@"1 lb spaghetti",
                         @"1/2 cup earth balance",
                         @"10 cloves garlic minced",
                         @"8oz spinach",
                         @"1 cup chopped kalamata olives",
                         @"1 cup chopped dry sun-dried tomatoes",
                         @"salt and pepper to taste"];
        
        _steps = @[@"cook pasta according to package directions",
                   @"add butter large non stick skillet med low",
                   @"add garlic and saute",
                   @"add spinach cook til wilted",
                   @"toss in pasta",
                   @"add olives and sun-dried tomatoes"];
        
        /// View
        self.view = [[UIView alloc] init];
        self.edgesForExtendedLayout = UIRectEdgeTop;
        [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]]];
        
        /// Nav Bar
        _navBar = [[UINavigationBar alloc] init];
        _navBar.translatesAutoresizingMaskIntoConstraints = NO;
        _navBar.delegate = self;
        
        _navItem = [[UINavigationItem alloc] init];
        
        UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setImage:[UIImage imageNamed:@"Cloud"] forState:UIControlStateNormal];
        [customButton sizeToFit];
        _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
        
        [_navBar pushNavigationItem:_navItem animated:YES];
        [_navBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
        
        /// Main Table View
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainTableView.estimatedRowHeight = 150.0;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /// Search Controller
        UITableViewController *_searchResultsTableVC = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchResultsTableVC];
        
        _searchResultsTableView = ((UITableViewController *)_searchController.searchResultsController).tableView;
        _searchResultsTableView.delegate = self;
        _searchResultsTableView.dataSource = self;
        _searchResultsTableView.estimatedRowHeight = 150.0;
        _searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
        
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        
        _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_searchController.searchBar sizeToFit];
        
        _mainTableView.tableHeaderView = _searchController.searchBar;
        
        /// Register Table View Cell Classes
        Class RecipeListCardClass = RecipeListCard.class;
        
        [_mainTableView registerClass:RecipeListCard.class forCellReuseIdentifier:NSStringFromClass(RecipeListCardClass)];
        [_searchResultsTableView registerClass:RecipeListCard.class forCellReuseIdentifier:NSStringFromClass(RecipeListCardClass)];
        
        [self.view setNeedsUpdateConstraints];
    }
    
    return self;
}


- (void)updateViewConstraints
{
    [self.view addSubview:_navBar];
    [self.view addSubview:_mainTableView];
    
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_mainTableView, _navBar, _topLayoutGuide);
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar][_mainTableView]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mainTableView]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:constraints];
    
    [super updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDatasource];
}

- (void)refreshDatasource
{
    if (!_context)
    {
        _context = [((AppDelegate *)[UIApplication sharedApplication].delegate) managedObjectContext];
    }
    
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass(Recipe.class)];
    //NSError *error;
    
    //_dataAllRecipes = [[_context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    _dataAllRecipes = @[@"garlic butter spaghetti with spinach, sun-dried tomatoes and olives",
                        @"creamy pesto pasta with vegan alfredo sauce and vegan banana and strawberry ice cream for desert",
                        @"spicy thai noodles",@"dinner for breakfast"];
    
    [_mainTableView reloadData];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
    
    _dataSearchedRecipes = [NSArray new];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    
    _dataSearchedRecipes = [_dataAllRecipes filteredArrayUsingPredicate:predicate];
    
    [_searchResultsTableView reloadData];
}

#pragma mark - TableView DataSource
#pragma mark

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((tableView == _searchResultsTableView) ? [_dataSearchedRecipes count] : [_dataAllRecipes count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeListCard *cell = (RecipeListCard *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RecipeListCard.class) forIndexPath:indexPath];
    
    NSInteger row = indexPath.row;
    
    // Choose the correct datasource
    NSArray *_datasource = ((tableView == _searchResultsTableView) ? _dataSearchedRecipes : _dataAllRecipes);
    //Recipe *recipe = (Recipe *)[_datasource objectAtIndex:row];
    
    
    //UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithName:@"Georgia-BoldItalic" size:30.0];
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:26.0];
    
    NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
    paragraphstyle.alignment = NSTextAlignmentJustified;
    paragraphstyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSShadow *drop = [[NSShadow alloc] init];
    drop.shadowOffset = CGSizeMake(0, 1);
    drop.shadowBlurRadius = 2;
    drop.shadowColor = [UIColor blackColor];
    UIColor *textforeground = [UIColor colorWithRed:0.37 green:0.75 blue:0.99 alpha:1];
    UIColor *stroke = [UIColor whiteColor];
    NSNumber *strokewidth = [NSNumber numberWithFloat:-3.0];
    NSNumber *kerning = [NSNumber numberWithInt:5];
    
    NSArray *objects = @[font, paragraphstyle, drop, textforeground, stroke, strokewidth, kerning];
    NSArray *keys = @[NSFontAttributeName, NSParagraphStyleAttributeName, NSShadowAttributeName, NSForegroundColorAttributeName, NSStrokeColorAttributeName, NSStrokeWidthAttributeName, NSKernAttributeName];
    
    NSDictionary *attrs = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    NSAttributedString *atrString = [[NSAttributedString alloc] initWithString:[_datasource objectAtIndex:row] attributes:attrs];
    
    cell.recipeLabel.attributedText = atrString;
    
    cell.ingredientsLabel.text = [_ingredients componentsJoinedByString:@"\n"];
    cell.stepsLabel.text = [_steps componentsJoinedByString:@"\n"];;
    
    
    UIFont *headerFont = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    
    NSMutableParagraphStyle *headerParagraphstyle = [[NSMutableParagraphStyle alloc] init];
    headerParagraphstyle.alignment = NSTextAlignmentLeft;
    NSShadow *headerDrop = [[NSShadow alloc] init];
    headerDrop.shadowOffset = CGSizeMake(0, 1);
    headerDrop.shadowBlurRadius = 2;
    headerDrop.shadowColor = [UIColor blackColor];
    UIColor *headerForeground = [UIColor colorWithRed:0.37 green:0.75 blue:0.99 alpha:1];
    UIColor *headerStroke = [UIColor whiteColor];
    NSNumber *headerStrokeWidth = [NSNumber numberWithFloat:-3.0];
    NSNumber *headerKerning = [NSNumber numberWithInt:2];
    
    NSArray *headerObjects = @[headerFont, headerParagraphstyle, headerDrop, headerForeground, headerStroke, headerStrokeWidth, headerKerning];
    NSArray *headerKeys = @[NSFontAttributeName, NSParagraphStyleAttributeName, NSShadowAttributeName, NSForegroundColorAttributeName, NSStrokeColorAttributeName, NSStrokeWidthAttributeName, NSKernAttributeName];
    
    NSDictionary *headerAttrs = [[NSDictionary alloc] initWithObjects:headerObjects forKeys:headerKeys];
    
    NSAttributedString *ingredientsHeaderAtrString = [[NSAttributedString alloc] initWithString:@"Ingredients" attributes:headerAttrs];
    NSAttributedString *stepsHeaderAtrString = [[NSAttributedString alloc] initWithString:@"Recipe" attributes:headerAttrs];
    
    cell.ingredientsHeader.attributedText = ingredientsHeaderAtrString;
    cell.stepsHeader.attributedText = stepsHeaderAtrString;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((tableView == _searchResultsTableView) ? NO : YES);
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Recipe *recipeToDelete = [_dataAllRecipes objectAtIndex:indexPath.row];
        
        [_context deleteObject:recipeToDelete];
        
        NSError *error;
        [_context save:&error];
        
        [self refreshDatasource];
        
        EmptyRecipeViewController *_emptyVC = [[EmptyRecipeViewController alloc] init];
        
        [self.splitViewController showDetailViewController:_emptyVC sender:self];
    }
}

#pragma mark - TableView Delegate
#pragma mark

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Private methods
#pragma mark

- (void)search:(UIBarButtonItem *)sender
{
    ///
}


- (void)add:(UIBarButtonItem *)sender
{
    _recipeTextVC = [[RecipeTextViewController alloc] init];
    
    _recipeTextVC.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self.splitViewController presentViewController:_recipeTextVC animated:YES completion:nil];
}

-(void)random:(UIButton *)sender
{
    
    //NSArray *_datasource = ((tableView == _searchResultsTableView) ? _dataSearchedRecipes : _dataAllRecipes);
    
    //Recipe *_recipe = [_datasource objectAtIndex:indexPath.row];
    
    //RecipeDetailViewController *_detailVC = [[RecipeDetailViewController alloc] initWithRecipe:_recipe];
    
    //[self.splitViewController showDetailViewController:_detailVC sender:self];
}

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar
{
    return UIBarPositionTopAttached;
}

@end
