//
//  SettingsViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SettingsViewController.h"
#import "HomeMainContentViewController.h"
#import "LocationSettingViewController.h"
#import "MyQuestionsViewController.h"
#import "MyReviewsViewController.h"
#import "FavoriteGuidesViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) HomeMainContentViewController *homeMainContentVC;

- (IBAction)onLocationButtonTapped:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma IBActions

- (IBAction)onHomeButtonTapped:(id)sender {
    self.homeMainContentVC = [[HomeMainContentViewController alloc] init];
    [self.delegate backToHomeScreenView:self.homeMainContentVC fromSettingVC:self];
}

- (IBAction)onLocationButtonTapped:(id)sender {
    LocationSettingViewController *locationSettingVC = [[LocationSettingViewController alloc] init];
    [self.delegate addLocationViewToHomeView:locationSettingVC fromSettingVC:self];
}

- (IBAction)onMyQuestionButtonTapped:(id)sender {
    MyQuestionsViewController *myQuestionsVC = [[MyQuestionsViewController alloc] init];
    [self.delegate addMyQuestionsViewToHomeView:myQuestionsVC.view fromSettingVC:self];
//    change something in HomeViewController
}

- (IBAction)onMyReviewsButtonTapped:(id)sender {
    MyReviewsViewController *myReviewsVC = [[MyReviewsViewController alloc] init];
    [self.delegate addMyReviewsViewToHomeView:myReviewsVC.view fromSettingVC:self];
}

- (IBAction)onFavoriteGuidesButtonTapped:(id)sender {
    FavoriteGuidesViewController *favoritesGuidesVC = [[FavoriteGuidesViewController alloc] init];
    [self.delegate addFavoriteGuidesViewToHomeView:favoritesGuidesVC.view fromSettingVC:self];
}

@end
