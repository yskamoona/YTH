//
//  GuideQuestions.h
//  YTH
//
//  Created by piyush shah on 7/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface GuideQuestions : PFObject <PFSubclassing>

+ (NSString *)parseClassName;

@property (retain) NSString *question;
@property  BOOL has_questions ;
@property NSString *parent;

@end