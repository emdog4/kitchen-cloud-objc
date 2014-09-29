//
//  CloudFlipButton.h
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import <UIKit/UIKit.h>

@interface CloudFlipButton : UIButton

@property (strong, nonatomic) UIButton *oppositeSideButton;
@property (strong, nonatomic) UITableViewCell *parentCell;

- (void)touchDown:(UIButton *)sender;
- (void)touchUp:(UIButton *)sender;

@end
