//
//  PlaceDetailViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PlaceDetailViewController.h"
#import "PostReviewViewController.h"
#import "Review.h"

@interface PlaceDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UITableView *reviewsTableView;
@property (weak, nonatomic) IBOutlet UILabel *servicesOffered;

@end

@implementation PlaceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getLocationsData];
}

- (void)getLocationsData
{
    if (self.placeInfo == nil) {
        self.placeInfo = [[Place alloc] init];
    }
    
    if (self.delegate != nil) {
        [self.delegate getLocationsInfoForFullMapVC:self];
    }
    
    self.placeNameLabel.text = self.placeInfo.name;
    self.placeAddressLabel.text = [self.placeInfo.address firstObject];
    //not sure what to show for services offered.
    self.servicesOffered.text = self.placeInfo.snippet_text;
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
        postReviewVC.place = self.placeInfo;
        postReviewVC.name = _placeNameLabel.text;
        [self presentViewController:postReviewVC animated:NO completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return reviews.count;
    return 7;
}


- (void) getReviews
{
    PFObject *review = [PFObject objectWithClassName:@"Review"];
    
    PFQuery *query = [Reviews query];
    [query whereKey:@"yelp_id" containsString:@"womens-community-clinic-san-francisco"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            Reviews *firstReview = objects[0];
            NSLog(@"got review %@",firstReview);
            // ...
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [self.reviewsTableView dequeueReusableCellWithIdentifier:@"ReviewCell" forIndexPath:indexPath];
    
    [self getReviews];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ReviewCell"];
    cell.textLabel.text = @"Some Info";
    cell.detailTextLabel.text = @"This is a review";
    return cell;
}

- (IBAction)onDragDown:(id)sender {
    //TBD
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onCallUsButtonPressed:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", self.placeInfo.display_phone];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:phoneNumber]];
}

@end
