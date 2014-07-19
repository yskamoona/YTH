//
//  PostReviewViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@protocol PostReviewViewControllerDelegate;

@interface PostReviewViewController : UIViewController

@property (assign) NSInteger stars;
@property(nonatomic, strong) Place *place;
@property(nonatomic, strong) NSString *name;
@property (weak, nonatomic) id <PostReviewViewControllerDelegate> delegate;

@end

@protocol PostReviewViewControllerDelegate <NSObject>


- (void)getUserStarReviewForPostReviewVC: (PostReviewViewController *)postReviewVC;
- (void)getUserPriceEstimationForPostReivewVC: (PostReviewViewController *)postReviewVC;

@end


