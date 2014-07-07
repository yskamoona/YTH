//
//  YTHHomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YTHHomeViewController.h"
#import "LocationDetailsViewController.h"
#import "LocationCell.h"


@interface YTHHomeViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;


@end

@implementation YTHHomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [_homeMapView setDelegate:self];
    [self setupCollectionView];
   // [self setLocationForMap];

}

- (void)viewDidAppear:(BOOL)animated
{
    MKCoordinateRegion region;
    region.center.latitude = 37.786996;
    region.center.longitude = -122.440100;
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.109863;
    [self.homeMapView setRegion:region animated:YES];
}



- (void)setupCollectionView {
    UINib *nib = [UINib nibWithNibName:@"LocationCell" bundle:nil];
    [self.homeCollectionView registerNib:nib forCellWithReuseIdentifier:@"LocationCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell *locationCell = [self.homeCollectionView dequeueReusableCellWithReuseIdentifier:@"LocationCell" forIndexPath:indexPath];
    return locationCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LocationDetailsViewController *locationDetailVC = [[LocationDetailsViewController alloc] init];
    [self presentViewController:locationDetailVC animated:NO completion:nil];
}

@end
