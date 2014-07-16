//
//  PlaceCellCustomHeaderView.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceCellCustomHeaderView.h"

@interface PlaceCellCustomHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;

@end

@implementation PlaceCellCustomHeaderView

- (void)setupCellHeaderWithPlaceImage:(UIImage *)placeImage {
    self.placeImageView.image = placeImage;
}

@end
