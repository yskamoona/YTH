//
//  GuideQuestions.m
//  YTH
//
//  Created by piyush shah on 7/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GuideQuestions.h"
#import <Parse/PFObject+Subclass.h>

@implementation GuideQuestions

@dynamic name;
@dynamic has_questions;
@dynamic parent;

+ (NSString *)parseClassName {
    return @"GuideQuestions";
}


@end
