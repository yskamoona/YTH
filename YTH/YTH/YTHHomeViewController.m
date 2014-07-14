//
//  YTHHomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YTHHomeViewController.h"
#import "FullMapViewController.h"
#import "PlaceDetailViewController.h"
#import "PostReviewViewController.h"
#import "FilterViewController.h"
#import "PlaceCell.h"
#import "Place.h"
#import "YelpClient.h"
#import <CoreLocation/CoreLocation.h>
#import "YTHLocationManager.h"
#import "Utils.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YTHHomeViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSMutableArray* searchResults;
@property (nonatomic, strong) Place *selectedLocationInfo;
@property (nonatomic, strong) NSMutableDictionary* filters;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) PlaceDetailViewController *fullMapVC;

@end

@implementation YTHHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    NSLog(@" initing with Nib");
    
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        self.filters = [[NSMutableDictionary alloc] initWithDictionary:@{@"term":@"clinic", @"location":@"San Francisco"}];
        
        [self doSearch];
        
        [YTHLocationManager sharedLocationManager];
        
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            self.locationManager.distanceFilter = 10;
            self.locationManager.delegate = self;
        }
        [self.locationManager startUpdatingLocation];

    }
    return self;
}

- (void)doSearch
{
    
    NSLog(@"In do search %@", self.filters);
    [self.client search:self.filters success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"REsponse from yelp: %@", response);
        
        __weak typeof(self) weakself = self;
        
        weakself.searchResults = [NSMutableArray array];
        
        [weakself.searchResults removeAllObjects];
        for (NSDictionary* dict in response[@"businesses"]) {
            
            Place *yelpListing;
            
            yelpListing = [MTLJSONAdapter modelOfClass:Place.class fromJSONDictionary:dict error:NULL];

            [weakself.searchResults addObject:yelpListing];
            NSLog(@"got data %@", yelpListing);
            NSLog(@"search result size: %lu", (unsigned long)[weakself.searchResults count]);
        }
    
        [weakself setupCollectionView];
        [weakself.homeCollectionView reloadData];
        [weakself setupMapView];
        
       // NSLog(@"search result size: %d", [self.searchResults count]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"got view did load");

    [_homeMapView setDelegate:self];
    [self setupCollectionView];
    
   // [self setLocationForMap];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Got view will Appear");
    [[self navigationController] setNavigationBarHidden:YES];
}

//- (void) locationManager:(CLLocationManager *)manager
//     didUpdateToLocation:(CLLocation *)newLocation
//            fromLocation:(CLLocation *)oldLocation {
//    self.currentLocation = newLocation;
//}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)setupMapView {
    
    MKCoordinateRegion region;
    region.center.latitude = 37.786996;
    region.center.longitude = -122.440100;
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.109863;
    [self.homeMapView setRegion:region animated:YES];
    
    self.currentLocation = [[CLLocation alloc] initWithLatitude:37.7873589 longitude:-122.408227];
    
    //NSLog(@"GETTING LOCATION 1 %@", self.currentLocation);
    //NSLog(@" getting searchResults %lu", (unsigned long)self.searchResults.count);
    
    if (self.currentLocation && self.searchResults.count > 0) {
        
        //NSLog(@"GETTING LOCATION %@", self.currentLocation);
        
        float distance = [Utils convertToMeter:0.5];
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.currentLocation.coordinate, distance, distance);
        [self.homeMapView setRegion:viewRegion];
        
        for (Place *location in self.searchResults) {
            NSString *address = [location.address componentsJoinedByString:@","];
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:address
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *topResult = [placemarks objectAtIndex:0];
                                 MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                                 
                                 MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                                 point.coordinate = placemark.coordinate;
                                 point.title = location.name;
                                 point.subtitle = address;
                                 [self.homeMapView addAnnotation:point];
                             }
                         }];
        }
    }
}

- (void)setupCollectionView
{
    UINib *nib = [UINib nibWithNibName:@"PlaceCell" bundle:nil];
    [self.homeCollectionView registerNib:nib forCellWithReuseIdentifier:@"PlaceCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlaceCell *placeCell = [self.homeCollectionView dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];
    Place *locationInfo = self.searchResults[indexPath.row];
    [placeCell setupCellWithLocationInfo:locationInfo];
    
    return placeCell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.fullMapVC = [[PlaceDetailViewController alloc] init];
    self.fullMapVC.delegate = self;
    self.selectedLocationInfo = self.searchResults[indexPath.row];
    [self presentViewController:self.fullMapVC animated:NO completion:nil];
}

- (void)getLocationsInfoForFullMapVC:(PlaceDetailViewController *)fullMapVC {
    fullMapVC.placesInfo = self.selectedLocationInfo;
}

- (IBAction)onFiltersButton:(id)sender
{
    FilterViewController *filterVC = [[FilterViewController alloc] init];
    [[self navigationController] setNavigationBarHidden:NO];
    [self.navigationController pushViewController:filterVC animated:YES];
}



@end
