//
//  Question.m
//  YTH
//
//  Created by Yousra Kamoona on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Question.h"
#import <Parse/PFObject+Subclass.h>

@implementation Question

@dynamic body;
@dynamic yth_pinned ;
@dynamic trending;
@dynamic replies;
@dynamic parent;

+ (NSString *)parseClassName {
    return @"Questions";
}

@end
