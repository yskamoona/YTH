//
//  RatingStarsViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReviewViewController.h"

@interface RatingStarsViewController : UIViewController <PostReviewViewControllerDelegate>

- (id)initWithReview:(NSInteger)starsReview;

@end
