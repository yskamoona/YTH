//
//  HomeMainContentViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMainContentViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UIView *homeContentMainView;

@end