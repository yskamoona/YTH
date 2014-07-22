//
//  MapUtils.m
//  YTH
//
//  Created by piyush shah on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MapUtils.h"
#import "Place.h"

@implementation MapUtils

/**
 MKCoordinateRegion viewRegion = [self RegionForAnnotations:_arrayPois];
 
 [_mapView setRegion:viewRegion animated:YES];
 */

-(void)zoomToFitMapAnnotations:(MKMapView*)mapView
{
    if([mapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    //for(MapUtils *annotation in mapView.annotations)// here MYAnnotation is custom annotation call.
    //{
   //     topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
  //      topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
  //      bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
  //      bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        
    //}
    
    NSLog(@"A%f, B%f, C%f, D%f,", topLeftCoord.latitude, topLeftCoord.longitude, bottomRightCoord.latitude, bottomRightCoord.longitude);
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
}

@end
