//
//  PlaceCell.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"

@interface PlaceCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *locImageView;
@property (assign) NSInteger randomStars;
@property (assign) NSInteger randomDollars;

- (void)setupCellWithPlaceInfo: (Place *)placeInfo;

@end
