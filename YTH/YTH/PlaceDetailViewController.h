//
//  FullMapViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@protocol PlaceDetailViewControllerDelegate;

@interface PlaceDetailViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) id <PlaceDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Place *placesInfo;

@end

@protocol PlaceDetailViewControllerDelegate <NSObject>

@required
- (void)getLocationsInfoForFullMapVC:(PlaceDetailViewController *)fullMapVC;

@end

