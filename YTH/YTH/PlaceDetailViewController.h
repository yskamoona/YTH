//
//  PlaceDetailViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
#import "PlaceDetailCell.h"
#import "FullMapViewController.h"

@interface PlaceDetailViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, PlaceDetailCellDelegate>

@property (nonatomic, strong) NSArray *placesInfo;

@end
