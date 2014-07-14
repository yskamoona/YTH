//
//  Place.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Place.h"
#import <MTLModel.h>//MTLModel
#import <MTLJSONAdapter.h>//MTLModel

@implementation Place

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name":@"name",
             @"address":@"location.display_address",
             @"snippet_text":@"snippet_text",
             @"yelp_id":@"id"
//             @"yelp-id":@"id"
//             @"latitude":@"location.coordinate.latitude",
//             @"longitude":@"location.coordinate.longitude"
             };
}

+ (NSArray *)placesWithArray:(NSArray *)array {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Place  *place= [[Place alloc] initWithDictionary:dictionary error:nil];
        [places addObject:place];
    }
    
    return places;
}

@end
