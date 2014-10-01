//
//  RecipeCollectionViewController.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/29/14.
//
//

#import "RecipeCollectionViewController.h"
#import "DynamicCollectionViewFlowLayout.h"
#import "RecipeCVDelegateDatasource.h"
#import "RecipeCollectionViewCell.h"

@interface RecipeCollectionViewController ()
{    
    UICollectionView *_collectionView;
    RecipeCVDelegateDatasource *_delegateDataSource;
    DynamicCollectionViewFlowLayout *_dynamicFlowLayout;
    UISwipeGestureRecognizer *_swipeGestureLeft;
    UISwipeGestureRecognizer *_swipeGestureRight;

}

@end

@implementation RecipeCollectionViewController

- (instancetype)init
{
    if (self = [super init])
    {
        _dynamicFlowLayout = [[DynamicCollectionViewFlowLayout alloc] init];
        _delegateDataSource = [[RecipeCVDelegateDatasource alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 414, 700) collectionViewLayout:_dynamicFlowLayout];
        
        _collectionView.delegate = _delegateDataSource;
        _collectionView.dataSource = _delegateDataSource;
        
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:RecipeCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RecipeCollectionViewCell.class)];
        
        _swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
        _swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    
        _swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        _swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_collectionView addGestureRecognizer:_swipeGestureLeft];
        [_collectionView addGestureRecognizer:_swipeGestureRight];
        
        [self.view setNeedsUpdateConstraints];
        [self.view updateConstraintsIfNeeded];
    }
    
    return self;
}

- (void)swipeGesture:(UISwipeGestureRecognizer *)sender
{
    if ([sender isKindOfClass:UISwipeGestureRecognizer.class])
    {
        CGPoint _swipe = [sender locationInView:_collectionView];
        NSIndexPath *_indexPath = [_collectionView indexPathForItemAtPoint:_swipe];
        RecipeCollectionViewCell *_cell = (RecipeCollectionViewCell *)[_collectionView cellForItemAtIndexPath:_indexPath];
        
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            [UIView transitionFromView:_cell.frontView toView:_cell.rearView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
                [_cell setNeedsUpdateConstraints];
                _cell.frontView.hidden = YES;
            }];
        }
        else if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        {
            _cell.frontView.hidden = NO;
            [UIView transitionFromView:_cell.rearView toView:_cell.frontView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
                [_cell setNeedsUpdateConstraints];
            }];
        }

    }
}

- (void)updateViewConstraints
{
    [self.view addSubview:_collectionView];
    
    id _topLayoutGuide = self.topLayoutGuide;
    
    NSMutableArray *_constraints = [NSMutableArray array];
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_collectionView, _topLayoutGuide);
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLayoutGuide][_collectionView]|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:_bindings]];
    
    [self.view addConstraints:_constraints];
    
    [super updateViewConstraints];
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
