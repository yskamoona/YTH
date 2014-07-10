//
//  FullMapViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@protocol FullMapViewControllerDelegate;

@interface FullMapViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) id <FullMapViewControllerDelegate> delegate;
@property (nonatomic, strong) Location *locationsInfo;

@end

@protocol FullMapViewControllerDelegate <NSObject>

@required
- (void)getLocationsInfoForFullMapVC:(FullMapViewController *)fullMapVC;

@end

