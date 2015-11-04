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
#import "RecipeMainViewController.h"

@interface RecipeCollectionViewController ()
{    
    UICollectionView *_collectionView;
    RecipeCVDelegateDatasource *_delegateDataSource;
    DynamicCollectionViewFlowLayout *_dynamicFlowLayout;
    UISwipeGestureRecognizer *_swipeGestureLeft;
    UISwipeGestureRecognizer *_swipeGestureRight;
    UITapGestureRecognizer *_tapGesture;
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
        _tapGesture= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        _swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        _swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        [_collectionView addGestureRecognizer:_swipeGestureLeft];
        [_collectionView addGestureRecognizer:_swipeGestureRight];
        [_collectionView addGestureRecognizer:_tapGesture];
        
        [self.view addSubview:_collectionView];
        
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
        
        [_cell.contentView removeConstraints:_cell.contentView.constraints];
        
        if ([_cell.editingView superview])
        {
            [_cell.editingView removeFromSuperview];
        }
        else
        {
            [_cell.contentView addSubview:_cell.editingView];
        }
        
        if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect newFrame = _cell.frame;
                CGFloat offset = newFrame.size.width / 4;
                newFrame.origin.x -= offset;
                newFrame.size.width += offset;
                _cell.frame = newFrame;
                [_cell setNeedsUpdateConstraints];
            } completion:^(BOOL finished) {
                ///
            }];
        }
        else if (sender.direction == UISwipeGestureRecognizerDirectionRight)
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGRect newFrame = _cell.frame;
                CGFloat offset = newFrame.size.width / 4;
                newFrame.origin.x = 0;
                newFrame.size.width -= offset;
                _cell.frame = newFrame;
                [_cell setNeedsUpdateConstraints];
            } completion:^(BOOL finished) {
                ///
            }];
        }

    }
}

- (void)tap:(UITapGestureRecognizer *)sender
{
    if ([sender isKindOfClass:UITapGestureRecognizer.class])
    {
        CGPoint _tap = [sender locationInView:_collectionView];
        NSIndexPath *_indexPath = [_collectionView indexPathForItemAtPoint:_tap];
        RecipeCollectionViewCell *_cell = (RecipeCollectionViewCell *)[_collectionView cellForItemAtIndexPath:_indexPath];
        
        RecipeMainViewController *_vc = [[RecipeMainViewController alloc] init];
        _vc.title = _cell.frontView.recipeLabel.text;
        [self.splitViewController showDetailViewController:_vc sender:self];
    }
}

- (void)updateViewConstraints
{
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
