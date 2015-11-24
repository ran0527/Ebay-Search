//
//  UIImage+Glyphicon.m
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "UIImage+Glyphicon.h"

@implementation UIImage (Glyphicon)

+ (instancetype)imageWithBool:(BOOL)value {
    NSString *name = value? @"checked": @"unchecked";
    return [UIImage imageNamed:name];
}

@end
