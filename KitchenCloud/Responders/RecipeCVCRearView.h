//
//  RecipeCVCRearView.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import <UIKit/UIKit.h>
#import "RecipeCVRearCVDelegateDatasource.h"

@interface RecipeCVCRearView : UIView

@property (strong, nonatomic) RecipeCVRearCVDelegateDatasource *delegateDataSource;
@property (strong, nonatomic) UICollectionView *rearCV;
@property (strong, nonatomic) UICollectionViewFlowLayout *rearCVFlowLayout;
@end

