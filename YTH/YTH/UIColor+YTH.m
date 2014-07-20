//
//  UIColor+YTH.m
//  YTH
//
//  Created by Yousra Kamoona on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "UIColor+YTH.h"

@implementation UIColor (YTH)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(float)alpha {
    UIColor * const DEFAULT_VOID_COLOR = [UIColor clearColor];
    
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
	//RON: strip # if it appears
    cString = [cString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
	// String should be 6 or 8 characters
	if ([cString length] < 6) return DEFAULT_VOID_COLOR;
    
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
	if ([cString length] != 6) return DEFAULT_VOID_COLOR;
    
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
    
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
    
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
    
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
    
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    return [UIColor colorWithHexString:stringToConvert withAlpha:1.0f];
}

+ (UIColor *)YTHBabyBlueColor {
	static UIColor* _YTHBabyBlueColor = nil;
	static dispatch_once_t YTHBabyBlueColorOnceToken;
	dispatch_once(&YTHBabyBlueColorOnceToken, ^
				  {
					  _YTHBabyBlueColor = [UIColor colorWithHexString:@"3CE3F0"];
				  });
    
	return _YTHBabyBlueColor;
}


@end
