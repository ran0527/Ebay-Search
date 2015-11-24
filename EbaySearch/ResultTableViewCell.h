//
//  ResultTableViewCell.h
//  EbaySearch
//
//  Created by Xinran on 4/25/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) NSDictionary *result;

-(void)configureWithResult:(NSDictionary *)result;

@end
