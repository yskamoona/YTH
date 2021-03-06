//
//  RatingStarsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "RatingStarsViewController.h"


@interface RatingStarsViewController ()

@property (weak, nonatomic) IBOutlet UIView *ratingsFillView;
- (IBAction)onFirstStar:(UIButton *)sender;
- (IBAction)onSecondStar:(UIButton *)sender;
- (IBAction)onThirdStar:(UIButton *)sender;
- (IBAction)onFourthStar:(UIButton *)sender;
- (IBAction)onFifthStar:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *firstStarButton;


@end

@implementation RatingStarsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithReview:(NSInteger)starsReview {
    self = [super initWithNibName:@"RatingStarsViewController" bundle:nil];
    if (self) {
          self.buttonValue = starsReview;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ratingsFillView.hidden = YES;
    //[self firstSetupWithPriceReview:self.buttonValue];
}

- (IBAction)onFirstStar:(UIButton *)sender {
    self.buttonValue = 1;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onSecondStar:(UIButton *)sender {
    self.buttonValue = 2;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onThirdStar:(UIButton *)sender {
    self.buttonValue = 3;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onFourthStar:(UIButton *)sender {
    self.buttonValue = 4;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onFifthStar:(UIButton *)sender {
    self.buttonValue = 5;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (void)firstSetupWithPriceReview:(NSInteger)starsReview {
    self.ratingsFillView.hidden = NO;
    self.ratingsFillView.frame = CGRectMake(0, 0, 50, 35);
    CGRectMake( self.firstStarButton.frame.origin.x,
                self.firstStarButton.frame.origin.y,
                self.firstStarButton.frame.size.width * starsReview - 4,
                self.firstStarButton.frame.size.height);
}

- (void)buttonPress:(UIButton *)sender withButtonValue:(NSInteger )buttonValue {
    self.ratingsFillView.hidden = NO;
    self.ratingsFillView.frame = CGRectMake(self.firstStarButton.frame.origin.x,
                                            self.firstStarButton.frame.origin.y,
                                            sender.frame.size.width * buttonValue - 4,
                                            sender.frame.size.height);
}

@end
