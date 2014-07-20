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

<<<<<<< HEAD
- (void)getPlacesData {

    [self getReviews];
=======
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
    
    Place *selectedPlace = self.placesInfo[self.startPlaceIndex];
    
//    self.placeNameLabel.text =  selectedPlace.name;
//    self.placeAddressLabel.text =   [selectedPlace.address firstObject];
        [self getReviews];
>>>>>>> 3d0e4e2c383c91d91dcb7b8d03f58d3b86003a1e
}

- (IBAction)onRateThisLocationButton:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Text Verification Message"
                                                        message:@"Text goes here..."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Sure!", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"user pressed OK");
    } else {
        PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
        postReviewVC.place = self.placesInfo[0];
//        postReviewVC.name = _placeNameLabel.text;
        [self presentViewController:postReviewVC animated:NO completion:nil];
    }
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
<<<<<<< HEAD
        [cell setupCellWithPlaceInfo:self.placesInfo[0]];
         cell.delegate = self;
        //[cell.callUsButton addTarget:self action:@selector(onCallUsButtonTapped:) forControlEvents:UIControlEventAllTouchEvents];
=======
        [cell setupCellWithPlaceInfo:self.placesInfo[0] forRow:indexPath.row];
        cell.delegate = self;
        cell.userInteractionEnabled = NO;
>>>>>>> 3d0e4e2c383c91d91dcb7b8d03f58d3b86003a1e
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
<<<<<<< HEAD
    fullMapVC.placeInfo = self.placesInfo[0];
=======
    fullMapVC.placesInfo = self.placesInfo;
    fullMapVC.showPlaceIndex = self.startPlaceIndexPath.section;
>>>>>>> 3d0e4e2c383c91d91dcb7b8d03f58d3b86003a1e
    //[self.navigationController pushViewController:fullMapVC animated:YES];
    [self presentViewController:fullMapVC animated:YES completion:nil];
}

- (void)didDismissAlertView:(UIAlertView *)alertView {
    PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
<<<<<<< HEAD
    postReviewVC.place = self.placesInfo[0];
=======
    postReviewVC.place = self.placesInfo;
>>>>>>> 3d0e4e2c383c91d91dcb7b8d03f58d3b86003a1e
    [self presentViewController:postReviewVC animated:NO completion:nil];
}

- (IBAction)onBackButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
