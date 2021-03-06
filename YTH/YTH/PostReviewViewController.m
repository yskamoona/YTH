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
#import "PriceRatingViewController.h"
#import "UIColor+YTH.h"

@interface PostReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *postReviewTextView;
@property (weak, nonatomic) IBOutlet UIView *ratingStarsView;
@property (weak, nonatomic) IBOutlet UIView *priceRatingView;
@property (weak, nonatomic) IBOutlet UIView *separatorView1;
@property (weak, nonatomic) IBOutlet UIView *separatorView2;
@property (weak, nonatomic) IBOutlet UIView *separatorView3;
@property (weak, nonatomic) IBOutlet UILabel *wereTheyFriendlyLable;
@property (weak, nonatomic) IBOutlet UILabel *offereHelpLabel;
@property (weak, nonatomic) IBOutlet UILabel *recommendLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureToEndEdit;

@property (strong, nonatomic) RatingStarsViewController *ratingStarsVC;
@property (strong, nonatomic) PriceRatingViewController *priceRatingVC;

@property BOOL friendly;
@property BOOL needsMet;
@property BOOL recommend;

@property (weak, nonatomic) IBOutlet UIButton *friendlyButton;
@property (weak, nonatomic) IBOutlet UIButton *friendlyNotButton;
@property (weak, nonatomic) IBOutlet UIButton *needsMetButton;
@property (weak, nonatomic) IBOutlet UIButton *needsMetNotButton;
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;
@property (weak, nonatomic) IBOutlet UIButton *recommendNotButton;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

- (IBAction)friendlyYes:(id)sender;
- (IBAction)friendlyNo:(id)sender;
- (IBAction)needsMetYes:(id)sender;
- (IBAction)needsMetNo:(id)sender;
- (IBAction)recommendYes:(id)sender;
- (IBAction)recommendNo:(id)sender;

- (IBAction)onTapGestureToEndEdit:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *publishButtonToTextViewConstraint;

@end

@implementation PostReviewViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.postReviewTextView.delegate = self;
    self.postReviewTextView.layer.cornerRadius = 3;
    
    self.whiteView.layer.cornerRadius = 3;
    [self.whiteView.layer setShadowOffset:CGSizeMake(5, 5)];
    [self.whiteView.layer setShadowColor:[[UIColor YTHGDarkTextColor] CGColor]];
    [self.whiteView.layer setShadowOpacity:0.5];
    
    self.placeNameLabel.text = self.place.name;
    self.navigationItem.title = @"Post a Review";
    
    self.ratingStarsVC = [[RatingStarsViewController alloc] initWithNibName:@"RatingStarsViewController" bundle:nil];
    [self.ratingStarsView addSubview:self.ratingStarsVC.view];
    
    self.priceRatingVC = [[PriceRatingViewController alloc] init];
    [self.priceRatingView addSubview:self.priceRatingVC.view];
    
    [self buttonsStyle];
    self.postReviewTextView.delegate = self;
}

#pragma UITextView Methods 

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self hideViewWhenWritingReview:YES];
    self.postReviewTextView.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self hideViewWhenWritingReview:NO];
    self.postReviewTextView.text = @"Write a review";
}

- (void)hideViewWhenWritingReview:(BOOL)isHidden {
    if (isHidden) {
        [UIView animateWithDuration:10.0
                              delay:1.0
             usingSpringWithDamping:.5f
              initialSpringVelocity:.5
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [UIView animateWithDuration:10.0 animations:^{
                                 self.middleViewHeightConstraint.constant = 50;
                                 self.publishButtonToTextViewConstraint.constant = 100;
                                 self.placeNameLabel.hidden = YES;
                                 self.separatorView1.hidden = YES;
                                 self.ratingStarsView.hidden = YES;
                                 self.priceRatingView.hidden = YES;
                                 self.separatorView2.hidden = YES;
                                 self.friendlyButton.hidden = YES;
                                 self.friendlyNotButton.hidden = YES;
                                 self.needsMetButton.hidden = YES;
                                 self.needsMetNotButton.hidden = YES;
                                 self.recommendButton.hidden = YES;
                                 self.recommendNotButton.hidden = YES;
                                 self.wereTheyFriendlyLable.hidden = YES;
                                 self.offereHelpLabel.hidden = YES;
                                 self.recommendLabel.hidden = YES;
                                 self.separatorView3.hidden = YES;
                                 self.whiteView.hidden = YES;
                                 
                             }];
                         } completion:^(BOOL finished) {
                         }];
    } else {
        [UIView animateWithDuration:10.0 animations:^{
            self.middleViewHeightConstraint.constant = 347;
            self.publishButtonToTextViewConstraint.constant = 0;
            self.placeNameLabel.hidden = NO;
            self.separatorView1.hidden = NO;
            self.ratingStarsView.hidden = NO;
            self.priceRatingView.hidden = NO;
            self.separatorView2.hidden = NO;
            self.friendlyButton.hidden = NO;
            self.friendlyNotButton.hidden = NO;
            self.needsMetButton.hidden = NO;
            self.needsMetNotButton.hidden = NO;
            self.recommendButton.hidden = NO;
            self.recommendNotButton.hidden = NO;
            self.wereTheyFriendlyLable.hidden = NO;
            self.offereHelpLabel.hidden = NO;
            self.recommendLabel.hidden = NO;
            self.separatorView3.hidden = NO;
            self.whiteView.hidden = NO;
        }];
    }
}

#pragma IBActions

- (IBAction)onPostReviewButton:(id)sender {
    Reviews *postReview = [Reviews object];
    //postReview[@"yelp_id"] = self.placeNameLabel.text;
    postReview[@"yelp_id"] = self.place.yelp_id;
    postReview[@"body"] = self.postReviewTextView.text;
    postReview[@"user"] = [PFUser currentUser];
    postReview.stars = self.ratingStarsVC.buttonValue;
    postReview.friendly = self.friendly;
    postReview.needsMet = self.needsMet;
    postReview.recommended = self.recommend;
    postReview.price = self.priceRatingVC.buttonValue;
    
    [postReview saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Review Posted!"
                                                            message:@"Thank you for the review!"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)friendlyYes:(id)sender {
    self.friendly = YES;
    
    self.friendlyButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.friendlyButton.titleLabel.textColor = [UIColor clearColor];

    self.friendlyNotButton.backgroundColor = [UIColor clearColor];
    self.friendlyNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
}

- (IBAction)friendlyNo:(id)sender {
    self.friendly = NO;
    
    self.friendlyNotButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.friendlyNotButton.titleLabel.textColor = [UIColor clearColor];
    
    self.friendlyButton.backgroundColor = [UIColor clearColor];
    self.friendlyButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
}

- (IBAction)needsMetYes:(id)sender {
    self.needsMet = YES;
    
    self.needsMetButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.needsMetButton.titleLabel.textColor = [UIColor clearColor];
    
    self.needsMetNotButton.backgroundColor = [UIColor clearColor];
    self.needsMetNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
}

- (IBAction)needsMetNo:(id)sender {
    self.needsMet = NO;
    
    self.needsMetNotButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.needsMetNotButton.titleLabel.textColor = [UIColor clearColor];
    
    self.needsMetButton.backgroundColor = [UIColor clearColor];
    self.needsMetButton.titleLabel.textColor =  [UIColor YTHBabyBlueColor];
    
}

- (IBAction)recommendYes:(id)sender {
    self.recommend = YES;
    
    self.recommendButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.recommendButton.titleLabel.textColor = [UIColor clearColor];
    
    self.recommendNotButton.backgroundColor = [UIColor clearColor];
    self.recommendNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
}

- (IBAction)recommendNo:(id)sender {
    self.recommend = NO;
    
    self.recommendNotButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.recommendNotButton.titleLabel.textColor = [UIColor clearColor];
    
    self.recommendButton.backgroundColor = [UIColor clearColor];
    self.recommendButton.titleLabel.textColor =  [UIColor YTHBabyBlueColor];
}

- (IBAction)onTapGestureToEndEdit:(UITapGestureRecognizer *)sender {
    [self.postReviewTextView resignFirstResponder];
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma  Buttons Style
- (void)buttonsStyle {
    
    self.friendlyButton.backgroundColor = [UIColor clearColor];
    self.friendlyButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    self.friendlyNotButton.backgroundColor = [UIColor clearColor];
    self.friendlyNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    
    self.friendlyButton.layer.cornerRadius = 3;
    self.friendlyButton.layer.borderWidth = 1;
    self.friendlyButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.friendlyNotButton.layer.cornerRadius = 3;
    self.friendlyNotButton.layer.borderWidth = 1;
    self.friendlyNotButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.needsMetButton.backgroundColor = [UIColor clearColor];
    self.needsMetButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    self.needsMetNotButton.backgroundColor = [UIColor clearColor];
    self.needsMetNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    
    self.needsMetButton.layer.cornerRadius = 3;
    self.needsMetButton.layer.borderWidth = 1;
    self.needsMetButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.needsMetNotButton.layer.cornerRadius = 3;
    self.needsMetNotButton.layer.borderWidth = 1;
    self.needsMetNotButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.recommendButton.backgroundColor = [UIColor clearColor];
    self.recommendButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    self.recommendNotButton.backgroundColor = [UIColor clearColor];
    self.recommendNotButton.titleLabel.textColor = [UIColor YTHBabyBlueColor];
    
    self.recommendButton.layer.cornerRadius = 3;
    self.recommendButton.layer.borderWidth = 1;
    self.recommendButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.recommendNotButton.layer.cornerRadius = 3;
    self.recommendNotButton.layer.borderWidth = 1;
    self.recommendNotButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;
    
    self.publishButton.backgroundColor = [UIColor YTHBabyBlueColor];
    self.publishButton.titleLabel.textColor = [UIColor whiteColor];
    self.publishButton.layer.cornerRadius = 3;
    self.publishButton.layer.borderWidth = 1;
    self.publishButton.layer.borderColor = [UIColor YTHBabyBlueColor].CGColor;

}

@end
