//
//  HomeViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"
#import "QuestionsViewController.h"

@interface HomeViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UITableViewDelegate, UITableViewDataSource, SettingsViewControllerDelegate, QuestionsViewControllerDelegate>


@end

