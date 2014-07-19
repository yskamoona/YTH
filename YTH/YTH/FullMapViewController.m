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

@interface FullMapViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *placeWithMapCollectionView;

@property (strong, nonatomic) CLLocation *currentLocation;
@end

@implementation FullMapViewController

- (void)locationUpdate:(CLLocation*)location;
{
    NSLog(@" FULL MAP getting location update in view %@", location);
    self.currentLocation = location;
    [self setupMapView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.delegate != nil) {
        [self.delegate getPlacesInfoForFullMapVC:self];
        self.placeInfo = [self.placesInfo firstObject];
    }

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
    if (self.placesInfo != nil) {
         return self.placesInfo.count;
    }
    else return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [self.placeWithMapCollectionView dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];
    if (self.placeInfo == nil) {
        [cell setupCellWithPlaceInfo:self.placesInfo[indexPath.row]];
    } else {
        [cell setupCellWithPlaceInfo:self.placeInfo];
    }
    return cell;
}


- (void)setupMapView {
    
    // Use San Francisco for simulator
   
    
    
    NSLog(@"GETTING LOCATION MAPVIEW %@", self.currentLocation);
    //NSLog(@" getting searchResults %lu", (unsigned long)self.searchResults.count);
    
    
        float distance = [Utils convertToMeter:0.5];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, distance, distance);

    [self.placeMapView setRegion:viewRegion];
    
    NSLog(@" placeinfo %@", self.placeInfo);
    
            NSString *address = [self.placeInfo.address componentsJoinedByString:@","];
    NSLog(@" address %@", address);
    
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:address
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                 
                                 MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                                 point.coordinate = placemark.coordinate;
                                 point.title = self.placeInfo.name;
                                 point.subtitle = address;
                                 [self.placeMapView addAnnotation:point];
                             }
                         }];

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
