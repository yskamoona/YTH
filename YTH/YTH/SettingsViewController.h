//
//  SettingsViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/17/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainContentViewController.h"

@class LocationSettingViewController;
@class MyReviewsViewController;
@class MyQuestionsViewController;
@class FavoriteGuidesViewController;

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id <SettingsViewControllerDelegate> delegate;

@end

@protocol SettingsViewControllerDelegate <NSObject>


- (void)backToHomeScreenView:(HomeMainContentViewController *)homeMainContentVC fromSettingVC:(SettingsViewController *)settingVC;
- (void)addLocationViewToHomeView:(LocationSettingViewController *)locationSettingsView fromSettingVC:(SettingsViewController *)settingVC;
- (void)addMyQuestionsViewToHomeView:(UIView *)myQestionsView fromSettingVC:(SettingsViewController *)settingVC;
- (void)addMyReviewsViewToHomeView:(UIView *)myReviewsView fromSettingVC:(SettingsViewController *)settingVC;
- (void)addFavoriteGuidesViewToHomeView:(UIView *)favoriteGuidesView fromSettingVC:(SettingsViewController *)settingVC;

@end