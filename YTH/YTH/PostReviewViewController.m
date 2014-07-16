//
//  PostReviewViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "PostReviewViewController.h"
#import "FullMapViewController.h"
#import <Parse/Parse.h>
#import "Review.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import <AMRatingControl/AMRatingControl.h>

@interface PostReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *postReviewTextView;

@property (weak, nonatomic) IBOutlet UILabel *start;

@property (weak, nonatomic) IBOutlet UILabel *end;
@property (weak, nonatomic) IBOutlet UILabel *startprice;

@property (weak, nonatomic) IBOutlet UILabel *endprice;

@property int stars;
@property int price;
@property BOOL friendly;
@property BOOL needsMet;
@property BOOL recommend;

- (IBAction)friendly:(id)sender;

- (IBAction)needsMet:(id)sender;
- (IBAction)recommend:(id)sender;
@end

@implementation PostReviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
  
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Create a simple instance, initing with :
    // - a CGPoint (the position in your view from which it will be drawn)
    // - and max rating
    AMRatingControl *starsRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(90, 150)
                                                                        andMaxRating:5];
    
    AMRatingControl *priceRatingControl = [[AMRatingControl alloc] initWithLocation:CGPointMake(90, 100)
                                                                       andMaxRating:4];
    
    [priceRatingControl setRating:2];
    [priceRatingControl setStarSpacing:10];
    // Customize the current rating if needed
    [starsRatingControl setRating:3];
    [starsRatingControl setStarSpacing:10];

    // Define block to handle events
	starsRatingControl.editingChangedBlock = ^(NSUInteger rating)
    {
        [_start setText:[NSString stringWithFormat:@"%d", rating]];
        self.stars = rating;
    };
    
    starsRatingControl.editingDidEndBlock = ^(NSUInteger rating)
    {
        [_end setText:[NSString stringWithFormat:@"%lu", (unsigned long)rating]];
        self.stars = rating;
    };
    
    // Define block to handle events
	priceRatingControl.editingChangedBlock = ^(NSUInteger price)
    {
        [_startprice setText:[NSString stringWithFormat:@"%d", price]];
        self.price = price;
    };
    
    priceRatingControl.editingDidEndBlock = ^(NSUInteger price)
    {
        [_endprice setText:[NSString stringWithFormat:@"%lu", (unsigned long)price]];
        self.price = price;
    };

    
    [self.view addSubview:starsRatingControl];
    [self.view addSubview:priceRatingControl];
    self.locNameLabel.text = self.place.name;
}

- (IBAction)onCloseReviewButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPostReviewButton:(id)sender {
    Reviews *postReview = [Reviews object];
    postReview[@"yelp_id"] = self.locNameLabel.text;
    postReview[@"body"] = self.postReviewTextView.text;

    postReview[@"user"] = [PFUser currentUser];
    postReview.stars = self.stars;
    postReview.friendly = self.friendly;
    postReview.needsMet =self.needsMet;
    postReview.recommended = self.recommend;
    postReview.price = self.price;
    
    [postReview saveInBackground];
}

- (IBAction)friendly:(id)sender {
    if ([sender isOn])
    {
        self.friendly = YES;
    }
    else
        self.friendly = NO;
    
}

- (IBAction)needsMet:(id)sender {
    if ([sender isOn])
    {
        self.needsMet = YES;
    }
    else
        self.needsMet = NO;
    

    
}

- (IBAction)recommend:(id)sender {
    
    if ([sender isOn])
    {
        self.recommend = YES;
    }
    else
        self.recommend = NO;
    

}
@end
