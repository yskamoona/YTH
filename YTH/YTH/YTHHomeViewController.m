//
//  YTHHomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "YTHHomeViewController.h"
#import "LocationDetailsViewController.h"
#import "FullMapViewController.h"
#import "PostReviewViewController.h"
#import "LocationCell.h"
#import "Location.h"
#import "YelpClient.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface YTHHomeViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;
@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionView;

@property (strong, nonatomic) YelpClient *client;
@property (nonatomic, strong) NSMutableArray* searchResults;
@property (nonatomic, strong) NSMutableDictionary* filters;

@end

@implementation YTHHomeViewController


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
        
        self.searchResults = [NSMutableArray array];
        
        [self.searchResults removeAllObjects];
        for (NSDictionary* dict in response[@"businesses"]) {
            
            Location *yelpListing;
            
            yelpListing = [MTLJSONAdapter modelOfClass:Location.class fromJSONDictionary:dict error:NULL];
            
            [self.searchResults addObject:yelpListing];
            NSLog(@"got data %@", yelpListing);
            //NSLog(@"search result size: %d", [self.searchResults count]);
        }
        
        [self setupCollectionView];
        [self.homeCollectionView reloadData];
       // NSLog(@"search result size: %d", [self.searchResults count]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupCollectionView {
    UINib *nib = [UINib nibWithNibName:@"LocationCell" bundle:nil];
    [self.homeCollectionView registerNib:nib forCellWithReuseIdentifier:@"LocationCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell *locationCell = [self.homeCollectionView dequeueReusableCellWithReuseIdentifier:@"LocationCell" forIndexPath:indexPath];
    
    Location *locationInfo = self.searchResults[indexPath.row];
    [locationCell setupCellWithLocationInfo:locationInfo];
    
    return locationCell;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FullMapViewController *fullMapVC = [[FullMapViewController alloc] init];
    [self presentViewController:fullMapVC animated:NO completion:nil];
}

@end
