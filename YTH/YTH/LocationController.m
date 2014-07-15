//
//  LocationController.m
//  testLocationSingleton
//
//  Created by piyush shah on 7/12/14.
//  Copyright (c) 2014 onor inc. All rights reserved.
//

#import "LocationController.h"

static LocationController* sharedCLDelegate = nil;

@implementation LocationController

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 10;
        self.locationManager.startUpdatingLocation;
    }
    return self;
}
#pragma mark - Singleton implementation in ARC
+ (LocationController *)sharedLocationController
{
    static LocationController *sharedLocationControllerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationControllerInstance = [[self alloc] init];
    });
    return sharedLocationControllerInstance;
}
#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager*)manager
    didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*)oldLocation
{
    [self.delegate locationUpdate:newLocation];
    /* ... */
    NSLog(@" did update to location %@", newLocation);
    
}

- (void) locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations {
    NSLog(@"Did update LOCATIONS %@", locations);
    
//    [self.delegate locationUpdate:newLocation];
    for (CLLocation *location in locations)
    {
        [self.delegate locationUpdate:location];
        NSDate *now = [NSDate date];
        if ([location.timestamp compare:[NSDate dateWithTimeIntervalSinceNow:-600]])
        {
            _locationManager.stopUpdatingLocation;
            break;
        }
    }
}

- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError*)error
{
    /* ... */
    
}
@end