//
//  QuestionDetailsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "QuestionDetailsViewController.h"
#import "QuestionDetailCell.h"

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
        cell.locationLabel.text = @"San Francisco";
        cell.anwersLabel.text = [NSString stringWithFormat:@"%ld answer", (long)self.question.replies];
        cell.timeLabel.text = @"1 min ago";
    } else {
        // else it is an answer cell
        cell.bodyLabel.text = @"Not sure how to implement this";
        cell.locationLabel.text = @"San Francisco";
        cell.timeLabel.text = @"1m ago";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 400;
    } else {
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 400;
    } else {
        return 200;
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
