//
//  MorningAfterViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MorningAfterViewController.h"
#import "HomeViewController.h"

@interface MorningAfterViewController ()
- (IBAction)onHomeButton:(id)sender;

@end

@implementation MorningAfterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Morning-After Pill";
    
    UIImage *homeButtonImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onHomeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO];
}

- (IBAction)onHomeButton:(id)sender{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [[self navigationController] setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}


@end
