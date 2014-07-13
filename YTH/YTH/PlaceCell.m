//
//  PlaceCell.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceCell.h"

@interface PlaceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *locImageView;
@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *locReviewImageView;

@end

@implementation PlaceCell

- (void)setupCellWithLocationInfo: (Place *)locationInfo
{
    self.locNameLabel.text    = locationInfo.name;
    self.locAddressLabel.text = [locationInfo.address firstObject];
}

@end