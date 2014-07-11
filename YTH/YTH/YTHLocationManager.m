//
//  YTHLocationManager.m
//  YTH
//
//  Created by piyush shah on 7/11/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YTHLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface YTHLocationManager ()

@property (retain, nonatomic) CLLocationManager* locationManager;

@end

@implementation YTHLocationManager

+ (id)sharedLocationManager {
    static dispatch_once_t pred;
    static YTHLocationManager *locationManagerSingleton = nil;
    
    dispatch_once(&pred, ^{
        locationManagerSingleton = [[self alloc] init];
    });
    return locationManagerSingleton;
}

-(id)init {

    if ((self = [super init]))
        {
        if (self.locationManager == nil) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            self.locationManager.distanceFilter = 10;
            self.locationManager.delegate = self;
            }
        }
    [self.locationManager startUpdatingLocation];
    return self;
   }


- (void) locationManager:(CLLocationManager *)manager
     didUpdateToLocation:(CLLocation *)newLocation
            fromLocation:(CLLocation *)oldLocation {
    //self.locationManager. = newLocation;

}

- (void) locationManager:(CLLocationManager *)manager
      didUpdateLocations:(NSArray *)locations {
    NSLog(@"Did update location");
    for (CLLocation *location in locations)
    {
        NSDate *now = [NSDate date];
        
        if ([location.timestamp compare:[NSDate dateWithTimeIntervalSinceNow:-600]])
        {
            self.locationManager.stopUpdatingLocation;
            break;
        }
    }
}


@end
