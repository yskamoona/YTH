//
//  QuestionDetailsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "QuestionDetailsViewController.h"
#import "QuestionDetailCell.h"
#import <Parse/Parse.h>
#import "UIColor+YTH.h"

@interface QuestionDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *questionDetailTableView;
@property (weak, nonatomic) IBOutlet UITextView *replyTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeightContraint;
@property (weak, nonatomic) IBOutlet UILabel *questionBody;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *repliesLabel;
@property (weak, nonatomic) IBOutlet UIView *dividerView;

@end

@implementation QuestionDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupQuestionView];
    [self setupTableView];
    self.replyTextField.delegate = self;
    self.navigationItem.title = @"Question Details";
    
    self.replyButton.backgroundColor = [UIColor YTHGreenColor];
    self.replyButton.titleLabel.textColor = [UIColor whiteColor];
    self.replyButton.layer.cornerRadius = 3;
    self.replyButton.layer.borderWidth = 1;
    self.replyButton.layer.borderColor = [UIColor YTHGreenColor].CGColor;
    
    self.replyTextField.delegate = self;
    self.replyTextField.layer.cornerRadius = 3;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)setupQuestionView {
    self.questionBody.text = self.question.body;
    self.questionBody.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
}

- (void)setupTableView {
    [self.questionDetailTableView  registerNib:[UINib nibWithNibName:@"QuestionDetailCell" bundle:nil] forCellReuseIdentifier:@"QuestionDetailCell"];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.replyTextField.text = @"";
    self.questionDetailTableView.hidden = YES;
    self.questionBody.hidden = YES;
    self.repliesLabel.hidden = YES;
    self.dividerView.hidden = YES;
    self.textFieldHeightContraint.constant = 60;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.questionDetailTableView.hidden = NO;
    self.questionBody.hidden = NO;
    self.textFieldHeightContraint.constant = 332;
}

#pragma UITableViewDelegate and UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.replies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionDetailCell *cell = [self.questionDetailTableView dequeueReusableCellWithIdentifier:@"QuestionDetailCell" forIndexPath:indexPath];
    
        // replies cell
        cell.anwersLabel.hidden = YES;
        cell.bodyLabel.text = [self.replies[indexPath.row] body];
        cell.bodyLabel.textColor = [UIColor YTHGreenColor];
        cell.bodyLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        cell.locationLabel.text = @"Los Angeles";
        cell.locationLabel.textColor = [UIColor YTHGreenColor];
        cell.locationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        cell.timeLabel.text = @"1m ago";
        cell.timeLabel.textColor = [UIColor YTHGreenColor];
        cell.timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        //cell.timeLabel.font = [UIFontWeightTrait
        cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma IBActions


- (IBAction)onReplyButtonTapped:(id)sender {
    Question *newReply = [Question object];
    newReply.body = self.replyTextField.text;
    newReply.parent = self.question.objectId;
    self.replyTextField.text = @"How can you help?";
    
    [newReply saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.replies addObject:newReply];
        [self.questionDetailTableView reloadData];
    }];
     [self.replyTextField resignFirstResponder];
    
}

- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender {
    [self.replyTextField resignFirstResponder];
    self.replyTextField.text = @"How can you help?";

}

@end
