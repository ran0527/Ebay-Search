//
//  BasicViewController.h
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

@property (strong, nonatomic) NSDictionary *result;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;
@property (strong, nonatomic) IBOutlet UILabel *formatLabel;

@end
