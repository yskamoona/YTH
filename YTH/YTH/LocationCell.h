//
//  LocationCell.h
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationCell : UICollectionViewCell

- (void)setupCellWithLocationInfo: (Location *)locationInfo;

@end
