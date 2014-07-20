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
}

- (IBAction)onCloseButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma IBActions

- (IBAction)onAskButtonTapped:(id)sender {
    Question *postQuestion = [Question object];
    postQuestion[@"body"] = self.questionTextView.text;
    postQuestion[@"user"] = [PFUser currentUser];
    
    [postQuestion saveInBackground];
}
@end
