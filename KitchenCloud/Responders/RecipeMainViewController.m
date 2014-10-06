//
//  RecipeMainViewController.m
//  KitchenCloud
//
//  Created by Emery Clark on 10/5/14.
//
//

#import "RecipeMainViewController.h"

#import "RecipeDetailCollectionViewFlowLayout.h"
#import "RecipeDetailCVDelegateDatasource.h"

@interface RecipeMainViewController ()
{
    UICollectionView *_mainCollectionView;
    RecipeDetailCollectionViewFlowLayout *_flowLayout;
    RecipeDetailCVDelegateDatasource *_delegateDatasource;
    UINavigationBar *_navBar;
    UINavigationItem *_navItem;
}
@end

@implementation RecipeMainViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.view = [[UIView alloc] init];
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        _flowLayout = [[RecipeDetailCollectionViewFlowLayout alloc] init];
        
        CGRect frame = self.view.frame;
        
        _delegateDatasource = [[RecipeDetailCVDelegateDatasource alloc] init];
        
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_flowLayout];
        _mainCollectionView.delegate = _delegateDatasource;
        _mainCollectionView.dataSource = _delegateDatasource;
        _mainCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        
        [_mainCollectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
        
        _navBar = [[UINavigationBar alloc] init];
        _navBar.translatesAutoresizingMaskIntoConstraints = NO;
        
        _navItem = [[UINavigationItem alloc] init];
        _navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss:)];
        
        [_navBar pushNavigationItem:_navItem animated:YES];
        
        [self.view addSubview:_navBar];
        [self.view addSubview:_mainCollectionView];
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
    }
    
    return self;
}

- (void)updateViewConstraints
{
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_mainCollectionView, _navBar, _topLayoutGuide);
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_navBar][_mainCollectionView]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_navBar]|" options:0 metrics:nil views:_bindings]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mainCollectionView]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:constraints];
    
    [super updateViewConstraints];
}

- (void)dismiss:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
