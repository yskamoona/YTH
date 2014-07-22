//
//  QuestionDetailsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "QuestionDetailsViewController.h"
#import "QuestionDetailCell.h"
#import "UIColor+YTH.h"

@interface QuestionDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *questionDetailTableView;
@property (weak, nonatomic) IBOutlet UITextView *replyTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldHeightContraint;

@end

@implementation QuestionDetailsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
    self.replyTextField.delegate = self;
    self.navigationItem.title = @"Question Details";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)setupTableView {
    [self.questionDetailTableView  registerNib:[UINib nibWithNibName:@"QuestionDetailCell" bundle:nil] forCellReuseIdentifier:@"QuestionDetailCell"];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.questionDetailTableView.hidden = YES;
    self.textFieldHeightContraint.constant = 60;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.questionDetailTableView.hidden = NO;
    self.textFieldHeightContraint.constant = 332;
}

#pragma UITableViewDelegate and UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.question.replies;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuestionDetailCell *cell = [self.questionDetailTableView dequeueReusableCellWithIdentifier:@"QuestionDetailCell" forIndexPath:indexPath];
    

    if (indexPath.row == 0) {
        cell.bodyLabel.text = self.question.body;
        //cell.bodyLabel.textColor = [UIColor YTHGDarkTextColor];
        cell.locationLabel.text = @"Los Angeles";
        cell.anwersLabel.text = [NSString stringWithFormat:@"%ld answer", (long)self.question.replies];
        cell.timeLabel.text = @"1m ago";
    } else {
        // else it is an answer cell
        cell.anwersLabel.hidden = YES;
        cell.bodyLabel.text = @"Not sure how to implement this";
        cell.bodyLabel.textColor = [UIColor YTHGDarkTextColor];
        cell.bodyLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14.0];
        cell.locationLabel.text = @"Los Angeles";
        cell.locationLabel.textColor = [UIColor YTHGDarkTextColor];
        cell.locationLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
        cell.timeLabel.text = @"1m ago";
        cell.timeLabel.textColor = [UIColor YTHGDarkTextColor];
        cell.locationLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    } else {
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200;
    } else {
        return 100;
    }
}

#pragma IBActions

- (IBAction)onReplyButtonTapped:(id)sender {
    //post Review
}

- (IBAction)onTapGesture:(UITapGestureRecognizer *)sender {
    [self.replyTextField resignFirstResponder];
}

@end
