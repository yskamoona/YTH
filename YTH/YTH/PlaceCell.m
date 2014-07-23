//
//  PlaceCell.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceCell.h"

@interface PlaceCell ()


@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *ratingPriceView;
@property (weak, nonatomic) IBOutlet UIImageView *locReviewImageView;
@property (weak, nonatomic) IBOutlet UIView *ratingStarView;
//@property (assign) NSInteger stars;
@property (weak, nonatomic) IBOutlet UIView *shadowView;



@end

@implementation PlaceCell


- (void)awakeFromNib {
    self.shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(2, 3);
    self.shadowView.layer.cornerRadius = 3;
    self.shadowView.layer.shadowOpacity = 0.3;
    self.shadowView.layer.shadowRadius = 1.0;
    self.shadowView.clipsToBounds = NO;
}

- (void)setupCellWithPlaceInfo: (Place *)placeInfo
{
    self.locNameLabel.text    = placeInfo.name;
    self.locAddressLabel.text = [placeInfo.address firstObject];
    
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

}

@end


