//
//  ClinicsViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PlaceDetailViewController.h"
#import "FullMapViewController.h"

@interface ClinicsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, CLLocationManagerDelegate, FullMapViewControllerDelegate, LocationControllerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, retain) CLLocationManager *locationManager;

@end
