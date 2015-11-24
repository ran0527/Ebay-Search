//
//  NSDictionary+Result.h
//  EbaySearch
//
//  Created by Xinran on 4/25/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Result)

-(NSString *)title;
-(NSString *)priceLine;
-(NSString *)imageUrl;
-(BOOL)freeShipping;
-(NSString *)location;
-(BOOL)isToprated;
-(NSString *)itemUrl;

// basic info
-(NSString *)category;
-(NSString *)condition;
-(NSString *)format;

// seller info
-(NSString *)username;
-(NSString *)feedbackScore;
-(NSString *)positive;
-(NSString *)feedbackRating;
-(BOOL)isTopratedSeller;
-(NSString *)store;

//shipping info
-(NSString *)shippingType;
-(NSString *)handlingTime;
-(NSString *)shippingLocation;
-(BOOL)expedited;
-(BOOL)oneDay;
-(BOOL)returnAccepted;
-(NSString *)fbDescription;

@end
