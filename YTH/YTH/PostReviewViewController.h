//
//  PostReviewViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface PostReviewViewController : UIViewController <UITextViewDelegate>

@property (assign) NSInteger stars;
@property (assign) NSInteger price;
@property(nonatomic, strong) Place *place;
@property(nonatomic, strong) NSString *name;

@end



