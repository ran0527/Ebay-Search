//
//  NSDictionary+Result.m
//  EbaySearch
//
//  Created by Xinran on 4/25/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "NSDictionary+Result.h"

@implementation NSDictionary (Result)

-(NSString *)title {
    NSString *result = nil;
    result = self[@"basicInfo"][@"title"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)priceLine {
    NSString *price = self[@"basicInfo"][@"convertedCurrentPrice"];
    NSString *cost = self[@"basicInfo"][@"shippingServiceCost"];
    NSString *shippingInfo = @"";
    if (self.freeShipping) {
        shippingInfo = @" (FREE Shipping)";
    } else if (cost.length > 0) {
        shippingInfo = [NSString stringWithFormat:@" (+ $%@ Shipping)", cost];
    }
    
    NSString *result = [NSString stringWithFormat:@"Price: $%@%@", price, shippingInfo];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)imageUrl {
    NSString *result = nil;
    result = self[@"basicInfo"][@"galleryURL"];
    return result.length > 0 ? result : @"N/A";
}

-(BOOL)freeShipping {
    NSString *cost = self[@"basicInfo"][@"shippingServiceCost"];
    NSString *type = self[@"shippingInfo"][@"shippingType"];
    return [type isEqualToString:@"Free"]
        || !cost
        || [cost isEqualToString:@"0.0"]
        || [cost isEqualToString:@""];
}

-(NSString *)location {
    NSString *result = nil;
    result = self[@"basicInfo"][@"location"];
    return result.length > 0 ? result : @"N/A";
}

-(BOOL)isToprated {
    return [self[@"basicInfo"][@"topRatedListing"] isEqualToString:@"true"];
}

-(NSString *)itemUrl {
    NSString *result = nil;
    result = self[@"basicInfo"][@"viewItemURL"];
    return result.length > 0 ? result : nil;
}

// basic info
-(NSString *)category {
    NSString *result = nil;
    result = self[@"basicInfo"][@"categoryName"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)condition {
    NSString *result = nil;
    result = self[@"basicInfo"][@"conditionDisplayName"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)format {
    NSString *result = nil;
    result = self[@"basicInfo"][@"listingType"];
    // screenshot shows "FixedPrice", indicating no need to change it
//    if ([result isEqualToString:@"FixedPrice"] || [result isEqualToString:@"StoreInventory"]) {
//        return @"Buy It Now";
//    } else if ([result isEqualToString:@"Auction"]) {
//        return @"Auction";
//    } else if ([result isEqualToString:@"Classified"]) {
//        return @"Classified Ad";
//    } else {
//        return result? result : @"";
//    }
    return result.length > 0 ? result : @"N/A";
}

// seller info
-(NSString *)username {
    NSString *result = nil;
    result = self[@"sellerInfo"][@"sellerUserName"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)feedbackScore {
    NSString *result = nil;
    result = self[@"sellerInfo"][@"feedbackScore"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)positive {
    NSString *result = nil;
    result = self[@"sellerInfo"][@"positiveFeedbackPercent"];
    return result.length > 0 ? result : @"N/A";
}

-(NSString *)feedbackRating {
    NSString *result = nil;
    result = self[@"sellerInfo"][@"feedbackRatingStar"];
    return result.length > 0 ? result : @"N/A";
}

-(BOOL)isTopratedSeller {
    return [self[@"sellerInfo"][@"topRatedSeller"] isEqualToString:@"true"];
}

-(NSString *)store {
    NSString *result = nil;
    result = self[@"sellerInfo"][@"sellerStoreName"];
    return result.length > 0? result: @"N/A";
}

//shipping info
-(NSString *)shippingType {
    NSString *result = nil;
    result = self[@"shippingInfo"][@"shippingType"];
    // match and replace string to add space before uppercase letter
    NSRegularExpression *regexp = [NSRegularExpression
                                   regularExpressionWithPattern:@"([a-z])([A-Z])"
                                   options:0
                                   error:NULL];
    NSString *newResult = [regexp
                           stringByReplacingMatchesInString:result
                           options:0
                           range:NSMakeRange(0, result.length)
                           withTemplate:@"$1 $2"];
    return newResult.length > 0 ? newResult : @"N/A";
}

-(NSString *)handlingTime {
    NSString *result = nil;
    result = self[@"shippingInfo"][@"handlingTime"];
    if ([result isEqualToString:@"1"]) {
        return [result stringByAppendingString:@" day"];
    } else if (result.length > 0) {
        return [result stringByAppendingString:@" days"];
    } else {
        return @"N/A";
    }
}

-(NSString *)shippingLocation {
    NSString *result = nil;
    result = self[@"shippingInfo"][@"shipToLocations"];
    return result.length > 0 ? result : @"N/A";
}

-(BOOL)expedited {
    return [self[@"shippingInfo"][@"expeditedShipping"] isEqualToString:@"true"];
}

-(BOOL)oneDay {
    return [self[@"shippingInfo"][@"oneDayShippingAvailable"] isEqualToString:@"true"];
}

-(BOOL)returnAccepted {
    return [self[@"shippingInfo"][@"returnsAccepted"] isEqualToString:@"true"];
}

-(NSString *)fbDescription {
    return [NSString stringWithFormat:@"%@, Location: %@", self.priceLine, self.location];
}

@end
