//
//  RecipeCVCRearView.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import "RecipeCVCRearView.h"
#import "RecipeCVCRearCollectionViewCell.h"

@interface RecipeCVCRearView ()

@end

@implementation RecipeCVCRearView

- (instancetype)init
{
    if (self = [super init])
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _delegateDataSource = [[RecipeCVRearCVDelegateDatasource alloc] init];
        
        _rearCVFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _rearCVFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _rearCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 150) collectionViewLayout:_rearCVFlowLayout];
        _rearCV.translatesAutoresizingMaskIntoConstraints = NO;
        _rearCV.backgroundColor = [UIColor clearColor];
        _rearCV.delegate = _delegateDataSource;
        _rearCV.dataSource = _delegateDataSource;
        
        [_rearCV registerClass:RecipeCVCRearCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RecipeCVCRearCollectionViewCell.class)];
    }
    return self;
}

- (void)updateConstraints
{
    NSDictionary *_bindings = NSDictionaryOfVariableBindings(_rearCV);
    NSMutableArray *_constraints = [NSMutableArray array];
    
    [self addSubview:_rearCV];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_rearCV]-|" options:0 metrics:nil views:_bindings]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_rearCV]-|" options:0 metrics:nil views:_bindings]];
    
    [self addConstraints:_constraints];
    
    [super updateConstraints];
}

@end
