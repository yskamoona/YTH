//
//  Utils.m
//  YTH
//
//  Created by piyush shah on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//


#import "Utils.h"
#import <UIImageView+AFNetworking.h>

@implementation Utils

+ (void)setImageWithUrl:(NSString *)url inImageView:(UIImageView *)imageView

{
    [imageView
     setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
     placeholderImage:nil
     success:^(NSURLRequest *request , NSHTTPURLResponse *response , UIImage *image ){
         imageView.image = image;
         NSLog(@"Loaded successfully: %ld", (long)[response statusCode]);
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
         NSLog(@"failed loading: %@", error);
     }
     ];
}

+ (float)convertToMeter:(float)miles {
    return miles * 1609;
}

+ (float)convertToMiles:(float)meters {
    return meters / 1609;
}


@end
