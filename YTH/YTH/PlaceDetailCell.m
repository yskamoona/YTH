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
#import "PriceRatingViewController.h"
#import "UIColor+YTH.h"

@interface PlaceDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIView *ratingStarView;
@property (weak, nonatomic) IBOutlet UIView *ratingPriceView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;

@property (weak, nonatomic) IBOutlet UILabel *servicesOffered;

@property (nonatomic, strong) Place *placeInfo;
@property (nonatomic, strong) RatingStarsViewController *ratingVC;

@property (nonatomic, strong) PriceRatingViewController *priceVC;

@property (weak, nonatomic) IBOutlet UIButton *callUsButton;
@property (weak, nonatomic) IBOutlet UIButton *typeAReviewButton;
@property (weak, nonatomic) IBOutlet UIView *shadowView;

@end

@implementation PlaceDetailCell


- (void)awakeFromNib {

    self.shadowView.layer.cornerRadius =  3;
    self.shadowView.layer.borderColor = [UIColor YTHGLightTextColor].CGColor;
    self.shadowView.layer.borderWidth = .3;

}


- (void)setupCellWithPlaceInfo:(Place *)placeInfo {
    //self.stars = [placeInfo.total_stars integerValue]/[placeInfo.total_reviews integerValue];
    
    
    
    //don't laugh at me!! It's just for Demo day!
    UIImage *smallStarImage = [UIImage imageNamed:@"starFilledSmall"];
    UIImageView *starImageView1 = [[UIImageView alloc] initWithImage:smallStarImage];
    UIImageView *starImageView2 = [[UIImageView alloc] initWithImage:smallStarImage];
    UIImageView *starImageView3 = [[UIImageView alloc] initWithImage:smallStarImage];
    UIImageView *starImageView4 = [[UIImageView alloc] initWithImage:smallStarImage];
    UIImageView *starImageView5 = [[UIImageView alloc] initWithImage:smallStarImage];
    
    starImageView1.frame = CGRectMake(0, 0, 15, 15);
    starImageView2.frame = CGRectMake(15, 0, 15, 15);
    starImageView3.frame = CGRectMake(30, 0, 15, 15);
    starImageView4.frame = CGRectMake(45, 0, 15, 15);
    starImageView5.frame = CGRectMake(60, 0, 15, 15);
    
    if (self.randomStars == 5) {
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
        [self.ratingStarView addSubview:starImageView4];
        [self.ratingStarView addSubview:starImageView5];
        
    }
    
    if (self.randomStars == 4) {
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
        [self.ratingStarView addSubview:starImageView4];
        
    }
    
    if (self.randomStars == 3) {
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
    }
    
    if (self.randomStars == 2) {
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
    }
    
    if (self.randomStars == 1) {
        [self.ratingStarView addSubview:starImageView1];
    }
    
    
    UIImage *smallDollarImage = [UIImage imageNamed:@"dollarFilledSmall"];
    UIImageView *dollarImageView1 = [[UIImageView alloc] initWithImage:smallDollarImage];
    UIImageView *dollarImageView2 = [[UIImageView alloc] initWithImage:smallDollarImage];
    UIImageView *dollarImageView3 = [[UIImageView alloc] initWithImage:smallDollarImage];
    UIImageView *dollarImageView4 = [[UIImageView alloc] initWithImage:smallDollarImage];
    UIImageView *dollarImageView5 = [[UIImageView alloc] initWithImage:smallDollarImage];
    
    dollarImageView1.frame = CGRectMake(0, 0, 10, 15);
    dollarImageView2.frame = CGRectMake(10, 0, 10, 15);
    dollarImageView3.frame = CGRectMake(20, 0, 10, 15);
    dollarImageView4.frame = CGRectMake(30, 0, 10, 15);
    dollarImageView5.frame = CGRectMake(40, 0, 10, 15);
    
    if (self.randomDollars == 5) {
        [self.ratingPriceView addSubview:dollarImageView1];
        [self.ratingPriceView addSubview:dollarImageView2];
        [self.ratingPriceView addSubview:dollarImageView3];
        [self.ratingPriceView addSubview:dollarImageView4];
        [self.ratingPriceView addSubview:dollarImageView5];
        
    }
    
    if (self.randomDollars == 4) {
        [self.ratingPriceView addSubview:dollarImageView1];
        [self.ratingPriceView addSubview:dollarImageView2];
        [self.ratingPriceView addSubview:dollarImageView3];
        [self.ratingPriceView addSubview:dollarImageView4];
        
    }
    
    if (self.randomDollars == 3) {
        [self.ratingPriceView addSubview:dollarImageView1];
        [self.ratingPriceView addSubview:dollarImageView2];
        [self.ratingPriceView addSubview:dollarImageView3];
    }
    
    if (self.randomDollars == 2) {
        [self.ratingPriceView addSubview:dollarImageView1];
        [self.ratingPriceView addSubview:dollarImageView2];
    }
    
    if (self.randomDollars == 1) {
        [self.ratingPriceView addSubview:dollarImageView1];
    }
    
    
    
    
    self.servicesOffered.text = @"Birth control puts you in charge. It allows you to plan the timing of your pregnancy, as well as prevent unwanted pregnancy. If you want to prevent pregnancy, there are many contraceptive options that we offer. You should choose which method is best for you based on your preferences, beliefs, health, and budget";
    
    self.placeInfo = placeInfo;
    self.placeImageView.image = [UIImage imageNamed:@"clinic2"];
    self.nameLabel.text = placeInfo.name;
    self.addressLabel.text = [placeInfo.address firstObject];
    self.hoursLabel.text = @"Mon - Fri : 8 am - 6 pm";
    
    
//    NSInteger starRating = 3;
//    NSInteger priceRating = 2;
//    //[placeInfo.total_stars integerValue]/[placeInfo.total_reviews integerValue];
//
//    self.ratingVC = [[RatingStarsViewController alloc] initWithReview:starRating];
//    //[self.starRatingView addSubview:self.ratingVC.view];
//    self.priceVC = [[PriceRatingViewController alloc] initWithReview:priceRating];
    //[self.priceRatingView addSubview:self.priceVC.view];
    [self addSubview:self.callUsButton];
    [self addSubview:self.typeAReviewButton];
}

#pragma IBActions

- (IBAction)onCallUsButtonTapped:(id)sender {
    if (self.delegate != nil) {
        [self.delegate placeDetailCell:self didClickButton:sender];
    }

}

- (IBAction)onGiveAReviewButtonTapped:(id)sender {
    [self.delegate didTapGiveAReviewButton];

}

@end
