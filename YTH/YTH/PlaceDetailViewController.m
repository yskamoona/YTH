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

@end

@implementation PlaceDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getPlacesData];
    [self setupTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)getPlacesData {

    [self getReviews];
}


- (void) getReviews {
    PFQuery *query = [Reviews query];
    [query whereKey:@"yelp_id" containsString:[self.placesInfo[0] yelp_id]];
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
        [cell setupCellWithPlaceInfo:self.placesInfo[0]];
         cell.delegate = self;
        //[cell.callUsButton addTarget:self action:@selector(onCallUsButtonTapped:) forControlEvents:UIControlEventAllTouchEvents];
        return cell;
    } else {
        ReviewCell *cell = [self.detailsTableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
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
    fullMapVC.placeInfo = self.placesInfo[0];
    //[self.navigationController pushViewController:fullMapVC animated:YES];
    [self presentViewController:fullMapVC animated:YES completion:nil];
}

- (void)didDismissAlertView:(UIAlertView *)alertView {
    PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
    postReviewVC.place = self.placesInfo[0];
    [self presentViewController:postReviewVC animated:NO completion:nil];
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
