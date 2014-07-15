//
//  FullMapViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FullMapViewController.h"
#import "PlaceCell.h"

@interface FullMapViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *placeWithMapCollectionView;

@end

@implementation FullMapViewController

- (void)locationUpdate:(CLLocation*)location;
{
    NSLog(@" getting location update in view %@", location);
    
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
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
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


@end
