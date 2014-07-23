//
//  ReviewCell.m
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "ReviewCell.h"
#import "Review.h"
#import "RatingStarsViewController.h"
#import "StarsView.h"

@interface ReviewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *reactionImage;
@property (weak, nonatomic) IBOutlet UIView *ratingStarView;
@property (weak, nonatomic) IBOutlet UILabel *reviewTimeStamp;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;


@property (nonatomic, strong) RatingStarsViewController *ratingVC;

@end

@implementation ReviewCell

- (id)setupCellWithReview:(Reviews *)review {
    
    // [placeInfo.total_stars integerValue]/[placeInfo.total_reviews integerValue];
    
    
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
    
    if (review.stars == 5) {
        self.reactionImage.image = [UIImage imageNamed:@"faceHappy"];
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
        [self.ratingStarView addSubview:starImageView4];
        [self.ratingStarView addSubview:starImageView5];
        
    }
    
    if (review.stars == 4) {
        self.reactionImage.image = [UIImage imageNamed:@"faceHappy"];
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
        [self.ratingStarView addSubview:starImageView4];
       
    }
    
    if (review.stars == 3) {
        self.reactionImage.image = [UIImage imageNamed:@"faceNeutral"];
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
        [self.ratingStarView addSubview:starImageView3];
    }
    
    if (review.stars == 2) {
        self.reactionImage.image = [UIImage imageNamed:@"faceSad"];
        [self.ratingStarView addSubview:starImageView1];
        [self.ratingStarView addSubview:starImageView2];
    }
        
    if (review.stars == 1) {
        self.reactionImage.image = [UIImage imageNamed:@"faceSad"];
       [self.ratingStarView addSubview:starImageView1];
    }

    self.reviewTimeStamp.text = @"Today";
    self.reviewLabel.text = review.body;
    
    return self;
}

@end
