//
//  Utils.h
//  YTH
//
//  Created by piyush shah on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)setImageWithUrl:(NSString *)url inImageView:(UIImageView *)imageView;

+ (UIColor *)getColorFrom:(CGFloat [3])rgb;

+ (float)convertToMeter:(float)miles;

+ (float)convertToMiles:(float)meters;

@end
