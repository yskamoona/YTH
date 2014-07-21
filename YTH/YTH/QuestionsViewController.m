//
//  QuestionsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "QuestionsViewController.h"
#import "Question.h"

@interface QuestionsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIButton *askButton;

- (IBAction)onAskButtonTapped:(id)sender;

@end

@implementation QuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma IBActions

- (IBAction)onAskButtonTapped:(id)sender {
    Question *postQuestion = [Question object];
    postQuestion[@"body"] = self.questionTextView.text;
    postQuestion[@"user"] = [PFUser currentUser];
    
    [postQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (self.delegate != nil) {
            [self.delegate didAskQuestionAndDimissViewController:self];
        }
    }];
    
}
@end
