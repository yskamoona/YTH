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

- (void)setupCellWithPlaceInfo: (Place *)placeInfo;

@end
