//
//  UIColor+YTH.h
//  YTH
//
//  Created by Yousra Kamoona on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YTH)

//Taken from ArsTechnica
//http://arstechnica.com/apple/2009/02/iphone-development-accessing-uicolor-components/

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)YTHBabyBlueColor;
@end
