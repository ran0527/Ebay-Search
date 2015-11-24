//
//  ResultTableViewCell.m
//  EbaySearch
//
//  Created by Xinran on 4/25/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "NSDictionary+Result.h"
#import "UIKit+AFNetworking.h"

@implementation ResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureWithResult:(NSDictionary *)result {
    self.priceLabel.font = [UIFont boldSystemFontOfSize:12];
    self.titleLabel.text = result.title;
    self.priceLabel.text = result.priceLine;
    [self.itemImage setImageWithURL:[NSURL URLWithString:result.imageUrl]];
    self.result = result;
    
    // register single tap on buynow image
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyNow)];
    singleTap.numberOfTapsRequired = 1;
    [self.itemImage setUserInteractionEnabled:YES];
    [self.itemImage addGestureRecognizer:singleTap];
}

-(void)buyNow {
    NSLog(@"Buy Now!");
    // open safari
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.result.itemUrl]];
}

@end
