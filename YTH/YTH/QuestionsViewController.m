//
//  QuestionsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "QuestionsViewController.h"
#import "Question.h"
#import "UIColor+YTH.h"

@interface QuestionsViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIButton *askButton;

- (IBAction)onAskButtonTapped:(id)sender;

@end

@implementation QuestionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Ask a Question";
    
    self.askButton.backgroundColor = [UIColor YTHGreenColor];
    self.askButton.titleLabel.textColor = [UIColor whiteColor];
    self.askButton.layer.cornerRadius = 3;
    self.askButton.layer.borderWidth = 1;
    self.askButton.layer.borderColor = [UIColor YTHGreenColor].CGColor;
    
    self.questionTextView.delegate = self;
    self.questionTextView.layer.cornerRadius = 3;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma IBActions

- (IBAction)onAskButtonTapped:(id)sender {
    
    // remove the text view
    [self.questionTextView resignFirstResponder];
    
    Question *postQuestion = [Question object];
    postQuestion[@"body"] = self.questionTextView.text;
    postQuestion[@"user"] = [PFUser currentUser];
    
    // insert spinner
    
    [postQuestion saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (self.delegate != nil) {
            NSLog(@"didAsk question now should dimiss");
            [self.delegate didAskQuestionAndDimissViewController:self];
        }
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"began editing");
    self.questionTextView.text = @"";
}


- (void)textViewDidEndEditing:(UITextView *)textView {
     NSLog(@"ended editing");
}

@end
