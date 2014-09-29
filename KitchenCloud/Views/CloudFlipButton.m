//
//  CloudFlipButton.m
//  KitchenCloud
//
//  Created by Emery Clark on 9/28/14.
//
//

#import "CloudFlipButton.h"

#import "RecipeFrontButton.h"
#import "RecipeRearButton.h"

@interface CloudFlipButton ()
{
    UIColor *_pattern;
}

@end

@implementation CloudFlipButton

- (instancetype)init
{
    if (self = [super init])
    {
        _pattern = [UIColor colorWithPatternImage:[UIImage imageNamed:@"card"]];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.4;
        
        [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside];
        
        [self setBackgroundColor:_pattern];
    }
    
    return self;
}

- (void)touchDown:(CloudFlipButton *)sender
{
    [UIView animateWithDuration:0.1 animations:^{
        sender.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
    }];
}

- (void)touchUp:(CloudFlipButton *)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         sender.layer.transform = CATransform3DIdentity;
                         
                         UIViewAnimationOptions option = UIViewAnimationOptionTransitionNone;
                         UIButton *destination = _oppositeSideButton;
                         
                         if ([sender isKindOfClass:RecipeFrontButton.class])
                         {
                             option = UIViewAnimationOptionTransitionFlipFromRight;
                         }
                         else if ([sender isKindOfClass:RecipeRearButton.class])
                         {
                             option = UIViewAnimationOptionTransitionFlipFromLeft;
                         }
                         
                         if (sender && destination)
                         {
                             destination.hidden = NO;
                             
                             [UIView transitionFromView:sender toView:destination duration:0.5 options:option completion:^(BOOL finished) {
                                 [self.parentCell setNeedsUpdateConstraints];
                                 sender.hidden = YES;
                             }];
                         }
                         
                     }
                     completion:nil
     ];
}

@end
