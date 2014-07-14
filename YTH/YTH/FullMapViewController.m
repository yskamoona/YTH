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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.delegate != nil) {
        [self.delegate getPlacesInfoForFullMapVC:self];
    }
    
    [self.placeWithMapCollectionView registerNib: [UINib nibWithNibName:@"PlaceCell"  bundle:nil ]forCellWithReuseIdentifier:@"PlaceCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.placesInfo.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [self.placeWithMapCollectionView dequeueReusableCellWithReuseIdentifier:@"PlaceCell" forIndexPath:indexPath];
    [cell setupCellWithPlaceInfo:self.placesInfo[indexPath.row]];
    return cell;
}


@end
