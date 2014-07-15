//
//  FullMapViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Place.h"
#import "LocationController.h"

@protocol FullMapViewControllerDelegate;

@interface FullMapViewController : UIViewController <MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,LocationControllerDelegate>

@property (weak, nonatomic) id <FullMapViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *placesInfo;
@property (nonatomic, strong) Place *placeInfo;

@property (nonatomic, retain) CLLocationManager *locationManager;

@end

@protocol FullMapViewControllerDelegate <NSObject>

- (void)getPlacesInfoForFullMapVC:(FullMapViewController *)placesInfoFullMapVC;
    
@end