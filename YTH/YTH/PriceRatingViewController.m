//
//  PriceRatingViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PriceRatingViewController.h"

@interface PriceRatingViewController ()

@property (weak, nonatomic) IBOutlet UIView *ratingsFillView;
- (IBAction)onFirstDollarSign:(UIButton *)sender;
- (IBAction)onSecondDollarSign:(UIButton *)sender;
- (IBAction)onThirdDollarSign:(UIButton *)sender;
- (IBAction)onFourthDollarSign:(UIButton *)sender;
- (IBAction)onFifthDollarSign:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *firstDollarSignButton;
@property (strong, nonatomic) IBOutlet UIButton *lastDollarSignButton;


@end

@implementation PriceRatingViewController

- (id)initWithReview:(NSInteger)priceReview {
    self = [super initWithNibName:@"PriceRatingViewController" bundle:nil];
    if (self) {
        self.buttonValue = priceReview;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.ratingsFillView.hidden = YES;
    //[self firstSetupWithPriceReview:self.buttonValue];
}

- (IBAction)onFirstDollarSign:(UIButton *)sender {
    self.buttonValue = 1;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onSecondDollarSign:(UIButton *)sender {
    self.buttonValue = 2;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onThirdDollarSign:(UIButton *)sender {
    self.buttonValue = 3;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onFourthDollarSign:(UIButton *)sender {
    self.buttonValue = 4;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (IBAction)onFifthDollarSign:(UIButton *)sender {
    self.buttonValue = 5;
    [self buttonPress:sender withButtonValue:self.buttonValue];
}

- (void)firstSetupWithPriceReview:(NSInteger)priceReview {
    self.ratingsFillView.hidden = NO;
    self.ratingsFillView.frame = CGRectMake(0,
                                            0,

                                            self.firstDollarSignButton.frame.size.width * priceReview,
                                            self.firstDollarSignButton.frame.size.height);
}

- (void)buttonPress:(UIButton *)sender withButtonValue:(NSInteger )buttonValue {
    self.ratingsFillView.hidden = NO;
    
    self.ratingsFillView.frame = CGRectMake(0, 0, (self.lastDollarSignButton.frame.origin.x - self.firstDollarSignButton.frame.origin.x) + self.lastDollarSignButton.frame.size.width, self.firstDollarSignButton.frame.size.height);
    
    self.ratingsFillView.frame = CGRectMake(0,
                                            0,
                                            self.firstDollarSignButton.frame.size.width * buttonValue,
                                            self.firstDollarSignButton.frame.size.height);
}

@end