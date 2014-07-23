//
//  MyQuestionsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MyQuestionsViewController.h" 
#import "QuestionDetailCell.h"
#import  <Parse/Parse.h>
#import "Question.h"

@interface MyQuestionsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myQuestionLabel;
@property (nonatomic, strong) Question *myquestion;

@end

@implementation MyQuestionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.myQuestionsTableViewController.delegate = self;
//    self.myQuestionsTableViewController.dataSource = self;
    
    
    PFQuery *query = [Question query];
    [query orderByDescending:@"createdAt"];
    [query whereKeyDoesNotExist:@"parent"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.myquestion = objects[0];
            NSLog(@"got question %@", self.myquestion);
            self.myQuestionLabel.text = self.myquestion.body;
        }
    }];
    
}




@end
