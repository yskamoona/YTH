//
//  PlaceDetailCell.h
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Place;

@protocol PlaceDetailCellDelegate;

@interface PlaceDetailCell : UITableViewCell



@property (weak, nonatomic) id <PlaceDetailCellDelegate> delegate;

- (void)setupCellWithPlaceInfo:(Place *)placeInfo;

@end

@protocol PlaceDetailCellDelegate <NSObject>

- (void)didTapGiveAReviewButton;
- (void)placeDetailCell: (PlaceDetailCell *)placeDetailCell didClickButton: (UIButton *)button;

@end