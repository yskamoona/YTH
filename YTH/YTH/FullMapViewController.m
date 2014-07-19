//
//  FullMapViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FullMapViewController.h"
#import "PlaceCell.h"
#import "Utils.h"
#import <MapKit/MapKit.h>

@interface FullMapViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *placeWithMapCollectionView;

@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) MKPointAnnotation *point;
@end

@implementation FullMapViewController

- (void)locationUpdate:(CLLocation*)location;
{
    NSLog(@" FULL MAP getting location update in view %@", location);
    self.currentLocation = location;
    [self setupMapView];
    [self setupMapRegion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.placeWithMapCollectionView registerNib: [UINib nibWithNibName:@"PlaceCell"  bundle:nil ]forCellWithReuseIdentifier:@"PlaceCell"];
    [LocationController sharedLocationController];
    [LocationController sharedLocationController].delegate = self;
    [[[LocationController sharedLocationController] locationManager] startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [[self navigationController] setNavigationBarHidden:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.placesInfo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [self.placeWithMapCollectionView dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];

    return cell;
}


- (void)setupMapView {
    
    NSLog(@"GETTING LOCATION MAPVIEW %@", self.currentLocation);
    //NSLog(@" getting searchResults %lu", (unsigned long)self.searchResults.count);
    
//          NSLog(@" placeinfo %@", self.placesInfo);
    
//    Place *showPlace = self.placesInfo[self.showPlaceIndex];
    for (Place *showPlace in self.placesInfo)
    {
    NSString *address = [showPlace.address componentsJoinedByString:@","];
//    NSLog(@" address %@", address);
    
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:address
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                 self.point = [[MKPointAnnotation alloc] init];
                                 self.point.coordinate = placemark.coordinate;
                                 self.point.title = [self.placesInfo[self.showPlaceIndex] name];
                                 self.point.subtitle = address;
                                 [self.placeMapView addAnnotation:self.point];
                             }
                        }];
    }
}

-(void) setupMapRegion {
    MKMapRect zoomRect = MKMapRectNull;
    NSLog(@" hey ");

    for (id <MKAnnotation> annotation in self.placeMapView.annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        NSLog(@" hey ");
        if (MKMapRectIsNull(zoomRect)) {
            zoomRect = pointRect;
        } else {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [self.placeMapView setVisibleMapRect:zoomRect animated:YES];
}

#pragma IBActions

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onHomeButtonTapped:(id)sender {
    
}

- (IBAction)onListButtonTapped:(id)sender {
    
}
    

@end
