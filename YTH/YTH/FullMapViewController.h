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
#import "PlaceDetailViewController.h"

@protocol FullMapViewControllerDelegate;

@interface FullMapViewController : UIViewController <MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, LocationControllerDelegate, MKAnnotation>
@property (strong, nonatomic) IBOutlet MKMapView *placeMapView;

@property (weak, nonatomic) id <FullMapViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *placesInfo;
@property (nonatomic, assign) NSInteger showPlaceIndex;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@end

@protocol FullMapViewControllerDelegate <NSObject>

- (void)getPlacesListAtBeginning;
- (void)getPlacesListAtIndexPath: (NSInteger)indexPath;

@end