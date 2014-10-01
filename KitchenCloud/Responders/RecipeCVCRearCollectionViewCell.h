//
//  RecipeCVCRearCollectionViewCell.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/30/14.
//
//

#import <UIKit/UIKit.h>

@interface RecipeCVCRearCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *leftLabel;
@property (strong, nonatomic) UILabel *rightLabel;

- (void)setupLabels;

@end
