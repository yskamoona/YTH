//
//  Question.h
//  YTH
//
//  Created by Yousra Kamoona on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Question : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *body;
@property  BOOL yth_pinned ;
@property  BOOL trending;
@property  NSInteger  replies;
@property NSString *parent;

@end
