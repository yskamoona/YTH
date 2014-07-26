//
//  PlaceDetailViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "PostReviewViewController.h"
#import "FullMapViewController.h"
#import "Review.h"
#import "ReviewCell.h"

@interface PlaceDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;
@property (strong, nonatomic) NSArray *reviews;

- (IBAction)onFullMapView:(id)sender;


@property (nonatomic, strong) Place *selectedPlace;


@end

@implementation PlaceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getPlacesData];
    [self setupNavigationBar];
    
//    self.startPlaceIndex = self.startPlaceIndexPath.item;
    [self setupTableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPlacesData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getPlacesData];
}

- (void)setupNavigationBar {
    self.navigationItem.title = @"Clinics";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIImage *homeButtonImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"map"]
//                                                                  style:UIBarButtonItemStylePlain
//                                                                 target:self
//                                                                 action:@selector(goToFullMapView:)];
    
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeButtonImage
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(onHomeButton:)];
    
    //self.navigationItem.rightBarButtonItems =  @[homeButton, mapButton];
    self.navigationItem.rightBarButtonItems =  @[homeButton];
}

- (void)goToFullMapView:(id)sender {
    FullMapViewController *fullMapVC = [[FullMapViewController alloc] init];
    fullMapVC.placesInfo = self.placesInfo;
    fullMapVC.showPlaceIndex = self.startPlaceIndex;
    [self.navigationController pushViewController:fullMapVC animated:YES];
}

- (void)getPlacesData
{
    if (self.placesInfo == nil) {
        self.placesInfo = [NSArray array];
    }
    
    self.selectedPlace = self.placesInfo[self.startPlaceIndex];
    [self getReviews];
}

- (void) getReviews {
    PFQuery *query = [Reviews query];
    [query whereKey:@"yelp_id" containsString:self.selectedPlace.yelp_id];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            self.reviews = objects;
            //Reviews *firstReview = [objects firstObject];
            //NSLog(@"got review %@",firstReview);
            [self.detailsTableView reloadData];
            [self.view layoutSubviews];
        }
    }];
}


#pragma SetUpTableView

- (void)setupTableView {
    //for first section
    [self.detailsTableView registerNib:[UINib nibWithNibName:@"PlaceDetailCell" bundle:nil] forCellReuseIdentifier:@"PlaceDetailCell"];
    //for second section
    [self.detailsTableView registerNib:[UINib nibWithNibName:@"ReviewCell" bundle:nil] forCellReuseIdentifier:@"ReviewCell"];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"you tapped");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

#pragma UITableViewDataSourceDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.reviews.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PlaceDetailCell *cell = [self.detailsTableView dequeueReusableCellWithIdentifier:@"PlaceDetailCell" forIndexPath:indexPath];
        cell.randomDollars = self.randomDollars;
        cell.randomStars = self.randomStars;
        [cell setupCellWithPlaceInfo:self.selectedPlace];
         cell.delegate = self;
        return cell;
    } else {
        ReviewCell *cell = [self.detailsTableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
        [cell setupCellWithReview:self.reviews[indexPath.row]];
        return cell;
    }
}

#pragma UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 680;
    } else {
        return 190;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 680;
        } else {
            return 200;
        }
}


#pragma PlaceDetailCellDelegate Methods

- (void)placeDetailCell:(PlaceDetailCell *)placeDetailCell didClickButton:(UIButton *)button {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", [self.placesInfo[0] display_phone]];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:phoneNumber]];
}

#pragma IBActions

- (void)onHomeButton:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onFullMapView:(id)sender {
    FullMapViewController *fullMapVC = [[FullMapViewController alloc] init];
    fullMapVC.placesInfo = self.placesInfo;
    fullMapVC.showPlaceIndex = self.startPlaceIndexPath.section;
//    [self.navigationController pushViewController:fullMapVC animated:YES];
    [self presentViewController:fullMapVC animated:YES completion:nil];
}

- (void)didTapGiveAReviewButton {
    PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
    postReviewVC.place = self.selectedPlace;
    [self.navigationController pushViewController:postReviewVC animated:YES];
}


@end
