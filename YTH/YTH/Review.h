//
//  Review.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Reviews : PFObject <PFSubclassing>

+ (NSString *)parseClassName;
@property (retain) NSString *body;
@property (retain) NSString *yelp_id;
@property  BOOL friendly;
@property  BOOL needsMet;
@property  BOOL recommended;
@property  NSInteger  stars;
@property  NSInteger price;


@end
