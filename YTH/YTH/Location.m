//
//  Location.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Location.h"
#import <MTLModel.h>//MTLModel
#import <MTLJSONAdapter.h>//MTLModel

@implementation Location

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
        Location  *location= [[Location alloc] initWithDictionary:dictionary error:nil];
        [locations addObject:location];
    }
    
    return locations;
    
}

@end
