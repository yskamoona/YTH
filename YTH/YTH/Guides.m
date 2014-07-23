//
//  Guide.m
//  YTH
//
//  Created by piyush shah on 7/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Guides.h"
#import <Parse/PFObject+Subclass.h>

@implementation Guides

@dynamic name;
@dynamic has_questions;
@dynamic parent;

+ (NSString *)parseClassName {
    return @"Guides";
}

@end
