//
//  HomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "ClinicsViewController.h"

const CGFloat widthConstraintMax = 320;

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) SettingsViewController *settingVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewWidthConstraint;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *containerViewPanGestureRecognizer;

@property (assign) NSInteger changingPosX;

- (IBAction)onSettingsButtonTapped:(id)sender;

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestureRecognizers];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
    
}

#pragma GestureRecongnizers

- (void)setupGestureRecognizers {
    
    //containerViewPanGestureRecognizer
    self.containerViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureForMainView:)];
    [self.mainView addGestureRecognizer:self.containerViewPanGestureRecognizer];
}

#pragma GesturesSelectors 

- (void)onPanGestureForMainView:(UIPanGestureRecognizer *)panGestureOnMainView {
    self.changingPosX = [panGestureOnMainView translationInView:self.view].x;
    // NSLog(@"Traslation in view.x %ld", (long)self.changingPosX);

    self.changingPosX = MIN(self.changingPosX, 260);
    self.changingPosX = MAX(self.changingPosX, 0);
    self.containerViewWidthConstraint.constant = 320 - self.changingPosX;
     self.mainViewWidthConstraint.constant = 320 - self.changingPosX;
    self.headerViewWidthConstraint.constant = 320 - self.changingPosX;
    
    if (panGestureOnMainView.state == UIGestureRecognizerStateEnded) {
        if (self.changingPosX >= 150) {
            [UIView animateWithDuration:.2 animations:^{
                self.containerViewWidthConstraint.constant = 60;
                self.mainViewWidthConstraint.constant = 60;
                self.headerViewWidthConstraint.constant = 60;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            
        } else {
            [UIView animateWithDuration:.2 animations:^{
                self.containerViewWidthConstraint.constant = widthConstraintMax;
                self.mainViewWidthConstraint.constant = widthConstraintMax;
                self.headerViewWidthConstraint.constant = widthConstraintMax;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    [self.view updateConstraints];
}


#pragma  AS Setting VC delegate methods

- (void)backToHomeScreenView:(HomeMainContentViewController *)homeMainContentVC fromSettingVC:(SettingsViewController *)settingVC {
   // [self.mainView addSubview:homeMainContentMainView];
    [self.navigationController pushViewController:homeMainContentVC animated:YES];
}

- (void)addLocationViewToHomeView:(UIView *)locationSettingsView fromSettingVC:(SettingsViewController *)settingVC {
    [self.mainView addSubview:locationSettingsView];
}

- (void)addMyQuestionsViewToHomeView:(UIView *)myQestionsView fromSettingVC:(SettingsViewController *)settingVC {
    [self.mainView addSubview:myQestionsView];
}

- (void)addMyReviewsViewToHomeView:(UIView *)myReviewsView fromSettingVC:(SettingsViewController *)settingVC {
    [self.mainView addSubview:myReviewsView];
}

- (void)addFavoriteGuidesViewToHomeView:(UIView *)favoriteGuidesView fromSettingVC:(SettingsViewController *)settingVC {
    [self.mainView addSubview:favoriteGuidesView];
}

#pragma IBActions

- (IBAction)onSettingsButtonTapped:(id)sender {
    if (self.containerViewWidthConstraint.constant == widthConstraintMax) {
        
        self.containerViewWidthConstraint.constant = 60;
        self.mainViewWidthConstraint.constant = 60;
        self.headerViewWidthConstraint.constant = 60;
    } else {
        self.containerViewWidthConstraint.constant = widthConstraintMax;
        self.mainViewWidthConstraint.constant = widthConstraintMax;
        self.headerViewWidthConstraint.constant = widthConstraintMax;
    }
   
    self.settingVC = [[SettingsViewController alloc] init];
    self.settingVC.delegate = self;
    [self.settingsView addSubview:self.settingVC.view];
}
@end
