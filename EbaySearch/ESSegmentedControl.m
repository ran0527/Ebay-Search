//
//  ESSegmentedControl.m
//  EbaySearch
//
//  Created by Xinran on 4/26/15.
//  Copyright (c) 2015 self.edu. All rights reserved.
//

#import "ESSegmentedControl.h"

@implementation ESSegmentedControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) setSelectedSegmentIndex:(NSInteger)toValue {
    if (self.selectedSegmentIndex == toValue) {
        [super setSelectedSegmentIndex:UISegmentedControlNoSegment];
    } else {
        [super setSelectedSegmentIndex:toValue];
    }
}

@end
