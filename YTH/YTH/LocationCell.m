//
//  LocationCell.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "LocationCell.h"

@interface LocationCell ()

@property (weak, nonatomic) IBOutlet UIImageView *locImageView;
@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locReviewImageView;

@end

@implementation LocationCell

- (void)setupCellWithLocationInfo: (Location *)locationInfo
{
    self.locNameLabel.text    = locationInfo.name;
    self.locAddressLabel.text = [locationInfo.address firstObject];
}

@end