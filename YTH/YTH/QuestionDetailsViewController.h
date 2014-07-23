//
//  QuestionDetailsViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"

@interface QuestionDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (strong, nonatomic) Question *question;
@property (strong, nonatomic) NSMutableArray *replies;

@end