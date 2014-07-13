//
//  Location.m
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
             @"address":@"location.display_address"
//             @"latitude":@"location.coordinate.latitude",
//             @"longitude":@"location.coordinate.longitude"
             };
}

+ (NSArray *)locationsWithArray:(NSArray *)array {
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array) {
        Place  *location= [[Place alloc] initWithDictionary:dictionary error:nil];
        [locations addObject:location];
    }
    
    return locations;
    
}

@end
