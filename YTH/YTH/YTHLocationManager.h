//
//  YTHLocationManager.h
//  YTH
//
//  Created by piyush shah on 7/11/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YTHLocationManager : NSObject <CLLocationManagerDelegate>

+(YTHLocationManager *)sharedLocationManager;


@end
