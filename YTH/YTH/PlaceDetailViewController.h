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

@interface PlaceDetailViewController : UIViewController <UIAlertViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, PlaceDetailCellDelegate>

@property (nonatomic, strong) NSArray *placesInfo;
<<<<<<< HEAD

@end
=======
@property (assign) NSIndexPath *startPlaceIndexPath;

@end

>>>>>>> 3d0e4e2c383c91d91dcb7b8d03f58d3b86003a1e
