//
//  PriceRatingViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReviewViewController.h"

@interface PriceRatingViewController : UIViewController <PostReviewViewControllerDelegate>

- (id)initWithReview:(NSInteger)priceReview;

@end
