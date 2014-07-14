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

@interface PostReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *postReviewTextView;

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
    
    self.locNameLabel.text = self.place.name;
}

- (IBAction)onCloseReviewButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onPostReviewButton:(id)sender {
    PFObject *postReview = [PFObject objectWithClassName:@"Reviews"];
    postReview[@"yelp_id"] = self.locNameLabel.text;
    postReview[@"body"] = self.postReviewTextView.text;
    [postReview saveInBackground];
}

@end
