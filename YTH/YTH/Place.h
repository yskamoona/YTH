//
//  Place.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import <MTLModel.h>//MTLModel
#import <MTLJSONAdapter.h>//MTLModel


@interface Place : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *display_phone;
@property (nonatomic, strong) NSArray  *categories;
@property (nonatomic, strong) NSArray  *review_count;
@property (nonatomic, strong) NSString *image_url;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSDictionary *location;
@property (nonatomic, strong) NSArray *address;
@property (nonatomic, strong) NSString *snippet_text;
@property (nonatomic, strong) NSString *yelp_id;

//DO: get the total stars and total reviews
@property (assign) NSNumber *total_stars;
@property (assign) NSNumber *total_reviews;

//@property double  *latitude;
//@property double   *longitude;



@end
