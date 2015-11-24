//
//  SellerViewController.h
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerViewController : UIViewController

@property (strong, nonatomic) NSDictionary *result;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (strong, nonatomic) IBOutlet UILabel *positiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *feedbackRatingLabel;
@property (strong, nonatomic) IBOutlet UILabel *storeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *topRatedSellerImage;

@end
