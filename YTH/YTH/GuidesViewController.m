//
//  GuidesViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GuidesViewController.h"
#import "GuidesDetailViewController.h"
#import "MorningAfterViewController.h"
#import "HomeViewController.h"
#import "STDsViewController.h"

@interface GuidesViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *guidesScroll;
@property (weak, nonatomic) IBOutlet UIView *guidesTitles;
@property (weak, nonatomic) IBOutlet UILabel *morningAfterLabel;
@property (weak, nonatomic) IBOutlet UILabel *stdsLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthControlLabel;
- (IBAction)onMorningAfterTapped:(id)sender;
- (IBAction)onHomeButton:(id)sender;
- (IBAction)onSTDsTapped:(UITapGestureRecognizer *)sender;
- (IBAction)onBirthControlTapped:(id)sender;

@end

@implementation GuidesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.guidesScroll.contentSize = self.guidesTitles.frame.size;
    [self.guidesScroll setScrollEnabled:true];
    
    self.navigationItem.title = @"Guides";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIImage *homeButtonImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onHomeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (IBAction)onMorningAfterTapped:(id)sender {
    //NSLog(@"you tapped Morning After Label");
    MorningAfterViewController *morningAfterVC = [[MorningAfterViewController alloc] init];
    [self.navigationController pushViewController:morningAfterVC animated:YES];

}

- (void)onHomeButton:(id)sender{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self.navigationController pushViewController:homeVC animated:YES];
}

- (IBAction)onSTDsTapped:(UITapGestureRecognizer *)sender {
    //NSLog(@"you tapped STDs Label");
    STDsViewController *stdsVC = [[STDsViewController alloc] init];
    [self.navigationController pushViewController:stdsVC animated:YES];
}

- (IBAction)onBirthControlTapped:(id)sender {
    GuidesDetailViewController *guidesDetailVC = [[GuidesDetailViewController alloc] init];
    
    [self.navigationController pushViewController:guidesDetailVC animated:YES];
}

@end
