//
//  Review.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Review.h"
#import <Parse/PFObject+Subclass.h>

@implementation Reviews
@dynamic body;

@dynamic yelp_id;
@dynamic recommended;
@dynamic needsMet;
@dynamic friendly;
@dynamic stars;
@dynamic price;

+ (NSString *)parseClassName {
    return @"Reviews";
}

@end
