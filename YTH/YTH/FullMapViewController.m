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

@property (weak, nonatomic) CLLocation *currentLocation;
@end

@implementation FullMapViewController

- (void)locationUpdate:(CLLocation*)location;
{
    NSLog(@" getting location update in view %@", location);
    self.currentLocation = location;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.delegate != nil) {
        [self.delegate getPlacesInfoForFullMapVC:self];
    }
    
    [self.placeWithMapCollectionView registerNib: [UINib nibWithNibName:@"PlaceCell"  bundle:nil ]forCellWithReuseIdentifier:@"PlaceCell"];
    [LocationController sharedLocationController];
    [LocationController sharedLocationController].delegate = self;
    
    [self setupMapView];
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
    
    MKCoordinateRegion region;
    region.center.latitude = 37.786996;
    region.center.longitude = -122.440100;
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.109863;
    [self.placeMapView setRegion:region animated:YES];
    
    self.currentLocation = [[CLLocation alloc] initWithLatitude:37.7873589 longitude:-122.408227];
    
    NSLog(@"GETTING LOCATION 1 %@", self.currentLocation);
    //NSLog(@" getting searchResults %lu", (unsigned long)self.searchResults.count);
    
        NSLog(@"GETTING LOCATION %@", self.currentLocation);
        
        float distance = [Utils convertToMeter:0.5];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, distance, distance);
        [self.placeMapView setRegion:viewRegion];
        
    
            NSString *address = [self.placeInfo.address componentsJoinedByString:@","];
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
