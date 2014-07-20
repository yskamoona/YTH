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


@interface ReviewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *reactionImage;
@property (weak, nonatomic) IBOutlet UIView *ratingStarView;
@property (weak, nonatomic) IBOutlet UILabel *reviewTimeStamp;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;

@property (nonatomic, strong) RatingStarsViewController *ratingVC;

@end

@implementation ReviewCell

- (id)setupCellWithReview:(Reviews *)review {
    self.reactionImage.image = [UIImage imageNamed:@"faceHappy"];
    
    NSInteger starRating = 3;
    //[placeInfo.total_stars integerValue]/[placeInfo.total_reviews integerValue];
    
    self.ratingVC = [[RatingStarsViewController alloc] initWithReview:starRating];
    [self.ratingStarView addSubview:self.ratingVC.view];
    self.reviewTimeStamp.text = @"2 Days Ago";
    self.reviewLabel.text = review.body;
    
    return self;
}

@end
