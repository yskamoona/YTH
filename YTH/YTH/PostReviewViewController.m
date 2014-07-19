//
//  PostReviewViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PostReviewViewController.h"
#import "FullMapViewController.h"
#import <Parse/Parse.h>
#import "Review.h"
#import "RatingStarsViewController.h"

@interface PostReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *postReviewTextView;

@property (weak, nonatomic) IBOutlet UILabel *start;

@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet UILabel *startprice;

@property (weak, nonatomic) IBOutlet UILabel *endprice;
@property (weak, nonatomic) IBOutlet UIView *ratingStarsView;
@property (strong, nonatomic) RatingStarsViewController *ratingStarsVC;




@property int price;
@property BOOL friendly;
@property BOOL needsMet;
@property BOOL recommend;

- (IBAction)friendly:(id)sender;
- (IBAction)needsMet:(id)sender;
- (IBAction)recommend:(id)sender;
@end

@implementation PostReviewViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.locNameLabel.text = self.place.name;
    
    self.ratingStarsVC = [[RatingStarsViewController alloc] initWithNibName:@"RatingStarsViewController" bundle:nil];
    
    [self.ratingStarsView addSubview:self.ratingStarsVC.view];
    self.delegate = self.ratingStarsVC;
    
}

- (IBAction)onCloseReviewButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPostReviewButton:(id)sender {
    Reviews *postReview = [Reviews object];
    postReview[@"yelp_id"] = self.locNameLabel.text;
    postReview[@"body"] = self.postReviewTextView.text;

    postReview[@"user"] = [PFUser currentUser];
    [self.delegate getUserStarReviewForPostReviewVC:self];
    postReview.stars = self.stars;
    postReview.friendly = self.friendly;
    postReview.needsMet =self.needsMet;
    postReview.recommended = self.recommend;
    postReview.price = self.price;
    
    [postReview saveInBackground];
}

- (IBAction)friendly:(id)sender {
    if ([sender isOn])
    {
        self.friendly = YES;
    }
    else
        self.friendly = NO;
    
}

- (IBAction)needsMet:(id)sender {
    if ([sender isOn])
    {
        self.needsMet = YES;
    }
    else
        self.needsMet = NO;
}

- (IBAction)recommend:(id)sender {
    
    if ([sender isOn])
    {
        self.recommend = YES;
    }
    else
        self.recommend = NO;
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
