//
//  LocationDetailsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "LocationDetailsViewController.h"
#import "Location.h"
#import "YelpClient.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface LocationDetailsViewController ()
@property (strong, nonatomic) YelpClient *client;
@property (nonatomic, strong) NSMutableArray* searchResults;
@property (nonatomic, strong) NSMutableDictionary* filters;
@end

@implementation LocationDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        self.filters = [[NSMutableDictionary alloc] initWithDictionary:@{@"term":@"clinic", @"location":@"San Francisco"}];
        
        [self doSearch];

    }
    return self;
    
    
}

- (void) doSearch {
    
    NSLog(@"In do search %@", self.filters);
    [self.client search:self.filters success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"REsponse from yelp: %@", response);
        
        [self.searchResults removeAllObjects];
        for (NSDictionary* dict in response[@"businesses"]) {
            
            Location *yelpListing;
            
            yelpListing = [MTLJSONAdapter modelOfClass:Location.class fromJSONDictionary:dict error:NULL];
            
            [self.searchResults addObject:yelpListing];
             NSLog(@"got data %@", yelpListing);
             NSLog(@"search result size: %d", [self.searchResults count]);
        }
        
        NSLog(@"search result size: %d", [self.searchResults count]);
        
        
       // [self.ListingTableView reloadData];
        
        //NSLog(@"search result size: %d", [self.searchResults count]);
        
        //    NSLog(@"got search %@", self.searchResults);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end
