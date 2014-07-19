//
//  PlaceDetailCell.m
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceDetailCell.h"
#import "Place.h"
#import "RatingStarsViewController.h"

@interface PlaceDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@property (nonatomic, strong) Place *placeInfo;
@property (nonatomic, strong) RatingStarsViewController *ratingVC;
@property (weak, nonatomic) IBOutlet UIButton *callUsButton;
@property (weak, nonatomic) IBOutlet UIButton *typeAReviewButton;

@end

@implementation PlaceDetailCell

- (void)setupCellWithPlaceInfo:(Place *)placeInfo forRow:(NSInteger)row {
    
    self.placeInfo = placeInfo;
    //self.imageView = placeInfo.image_url;
    self.nameLabel.text = placeInfo.name;
    self.addressLabel.text = [placeInfo.address firstObject];
    self.hoursLabel.text = @"Mon - Fri : 8 am - 6 pm";
    
    
    NSInteger starRating = 3;
    //[placeInfo.total_stars integerValue]/[placeInfo.total_reviews integerValue];

    self.ratingVC = [[RatingStarsViewController alloc] initWithReview:starRating];
    [self.starRatingView addSubview:self.ratingVC.view];
    self.ratingVC.view.userInteractionEnabled = NO;
    
    if (row == 1) {
        
    }
}

#pragma IBActions

- (IBAction)onCallUsButtonTapped:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", self.placeInfo.display_phone];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:phoneNumber]];
}

- (void)onGiveAReviewButtonTapped:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Text Verification Message"
                                                        message:@"Text goes here..."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Sure!", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"user pressed Cancel");
    } else {
        [self.delegate didDismissAlertView:alertView];
    }
}

@end
