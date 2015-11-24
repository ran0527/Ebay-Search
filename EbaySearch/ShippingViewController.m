//
//  ShippingViewController.m
//  EbaySearch
//
//  Created by Xinran on 4/29/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "ShippingViewController.h"
#import "NSDictionary+Result.h"
#import "UIImage+Glyphicon.h"

@interface ShippingViewController ()
@property (strong, nonatomic) IBOutlet UILabel *shippingTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *handlingLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *expeditedImage;
@property (strong, nonatomic) IBOutlet UIImageView *oneDayImage;
@property (strong, nonatomic) IBOutlet UIImageView *returnImage;

@end

@implementation ShippingViewController

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
    self.shippingTypeLabel.text = self.result.shippingType;
    self.handlingLabel.text = self.result.handlingTime;
    self.locationLabel.text = self.result.shippingLocation;
    self.expeditedImage.image = [UIImage imageWithBool:self.result.expedited];
    self.oneDayImage.image = [UIImage imageWithBool:self.result.oneDay];
    self.returnImage.image = [UIImage imageWithBool:self.result.returnAccepted];
}

@end
