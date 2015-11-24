//
//  UIViewController+Toast.m
//  EbaySearch
//
//  Created by Xinran on 15/4/29.
//  Copyright (c) 2015年 self.edu. All rights reserved.
//

#import "UIViewController+Toast.h"

@implementation UIViewController (Toast)

- (void)showToastWithMessage:(NSString *)message {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenSize.width * 0.5, 30)];
    label.text = message;
    label.font = [UIFont boldSystemFontOfSize:14];
    [label sizeToFit];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, label.frame.size.width + 40, label.frame.size.height + 40);
    label.center = CGPointMake(screenSize.width / 2, screenSize.height - label.frame.size.height / 2 - 80);
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 20;
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 delay:3 options:0 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}

@end
