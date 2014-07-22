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

@property (assign) NSInteger startPlaceIndex;
@property (nonatomic, strong) Place *selectedPlace;

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getPlacesData];
    self.startPlaceIndex = self.startPlaceIndexPath.section;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Map_view_button"] style:UIBarButtonItemStyleBordered target:self action:@selector(goToFullMapView:)];
    [self setupTableView];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//- (void)goToFullMapView:(id)sender {
//    FullMapViewController *fullMapVC = [[FullMapViewController alloc] init];
//    fullMapVC.placeInfo = self.placeInfo;
//    [self.navigationController pushViewController:fullMapVC animated:YES];
//}

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
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.reviews = objects;
            Reviews *firstReview = [objects firstObject];
            NSLog(@"got review %@",firstReview);
            [self.detailsTableView reloadData];
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
        return 600;
    } else {
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 600;
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

- (IBAction)onFullMapView:(id)sender {
    FullMapViewController *fullMapVC = [[FullMapViewController alloc] init];
    fullMapVC.placesInfo = self.placesInfo;
    fullMapVC.showPlaceIndex = self.startPlaceIndexPath.section;
    //[self.navigationController pushViewController:fullMapVC animated:YES];
    [self presentViewController:fullMapVC animated:YES completion:nil];
}

- (void)didDismissAlertView:(UIAlertView *)alertView {
    PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
    postReviewVC.place = self.selectedPlace;
    [self presentViewController:postReviewVC animated:NO completion:nil];
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
