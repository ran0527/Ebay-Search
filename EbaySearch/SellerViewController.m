//
//  SellerViewController.m
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "SellerViewController.h"
#import "NSDictionary+Result.h"
#import "UIImage+Glyphicon.h"

@interface SellerViewController ()

@end

@implementation SellerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    self.usernameLabel.text = self.result.username;
    self.feedbackLabel.text = self.result.feedbackScore;
    self.positiveLabel.text = self.result.positive;
    self.feedbackRatingLabel.text = self.result.feedbackRating;
    self.topRatedSellerImage.image = [UIImage imageWithBool:self.result.isTopratedSeller];
    self.storeLabel.text = self.result.store;
}

@end
