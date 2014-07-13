//
//  FullMapViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/7/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FullMapViewController.h"
#import "PostReviewViewController.h"

@interface FullMapViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;

@end

@implementation FullMapViewController

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
    if (self.locationsInfo == nil)
    {
        self.locationsInfo = [[Location alloc] init];
    }
    
    if (self.delegate != nil)
    {
        [self.delegate getLocationsInfoForFullMapVC:self];
    }
}

- (IBAction)onRateThisLocationButton:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Text Verification Message"
                                                        message:@"Text goes here..."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Sure!", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"user pressed OK");
    } else {
        PostReviewViewController *postReviewVC = [[PostReviewViewController alloc] init];
        [self presentViewController:postReviewVC animated:NO completion:nil];
    }
}

- (IBAction)onDragDown:(id)sender {
    //TBD
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)onCallUsButtonPressed:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@", self.locationsInfo.display_phone];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:phoneNumber]];
}

@end
