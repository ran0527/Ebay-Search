//
//  DetailViewController.m
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "DetailViewController.h"
#import "UIKit+AFNetworking.h"
#import "NSDictionary+Result.h"
#import "BasicViewController.h"
#import "SellerViewController.h"
#import "ESSegmentedControl.h"
#import "ShippingViewController.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import "UIViewController+Toast.h"

@interface DetailViewController () <FBSDKSharingDelegate>

@property (strong, nonatomic) IBOutlet UIView *basicContainerView;
@property (strong, nonatomic) IBOutlet UIView *sellerContainerView;
@property (strong, nonatomic) IBOutlet UIView *shippingContainerView;
@property (strong, nonatomic) IBOutlet ESSegmentedControl *tabSegControl;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set toprated image
    self.topratedImage.image = [UIImage imageNamed:@"itemTopRated"];
    self.buynowImage.image = [UIImage imageNamed:@"buy-now"];
    
    // register single tap on buynow image
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyNow)];
    singleTap.numberOfTapsRequired = 1;
    [self.buynowImage setUserInteractionEnabled:YES];
    [self.buynowImage addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"result: %@", self.result);
    [self configureView];
    self.scrollView.contentSize = CGSizeMake(320, 600);
}

- (void)configureView {
    [self.itemImage setImageWithURL:[NSURL URLWithString:self.result.imageUrl]];
    self.titleLabel.text = self.result.title;
    self.priceLabel.text = self.result.priceLine;
    self.priceLabel.font = [UIFont boldSystemFontOfSize:12];
    self.locationLabel.text = self.result.location;
    // set hidden property of toprated image
    self.topratedImage.hidden = !self.result.isToprated;
}

- (IBAction)didClickFacebookShareButton:(UIButton *)sender {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:self.result.itemUrl];
    content.contentDescription = self.result.fbDescription;
    [FBSDKShareDialog showFromViewController:self withContent:content delegate:self];
}


-(void)buyNow {
    NSLog(@"Buy Now!");
    // open safari
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.result.itemUrl]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString: @"showBasic"]) {
        BasicViewController *controller = (BasicViewController *)segue.destinationViewController;
        controller.result = self.result;
    } else if ([segue.identifier isEqualToString: @"showSeller"]) {
        SellerViewController *controller = (SellerViewController *)segue.destinationViewController;
        controller.result = self.result;
    } else if ([segue.identifier isEqualToString: @"showShipping"]) {
        ShippingViewController *controller = (ShippingViewController *)segue.destinationViewController;
        controller.result = self.result;
    }
}

#pragma mark - segmented control

- (IBAction)tabIndexChanged:(id)sender {
    NSInteger selected = self.tabSegControl.selectedSegmentIndex;
    for (int i = 0; i < 3; i++) {
        if (selected != i) {
            // hide corresponding view controller
            [self containerViewForTabIndex:i].hidden = TRUE;
        } else {
            // toggle corresponding view controller
            [self containerViewForTabIndex:i].hidden = ![self containerViewForTabIndex:i].hidden;
        }
    }
}

- (UIView *)containerViewForTabIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return self.basicContainerView;
        case 1:
            return self.sellerContainerView;
        case 2:
            return self.shippingContainerView;
        default:
            return nil;
    }
}

#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    NSLog(@"%@", results);
    if (results[@"postId"])
        [self showToastWithMessage:[NSString stringWithFormat:@"ID: %@", results[@"postId"]]];
    else
        [self showToastWithMessage:@"Post Cancelled"];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    [self showToastWithMessage:[NSString stringWithFormat:@"Error: %@", error.localizedDescription]];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    [self showToastWithMessage:[NSString stringWithFormat:@"Post Cancelled"]];
}

@end
