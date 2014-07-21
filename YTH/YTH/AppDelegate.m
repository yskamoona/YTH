//
//  AppDelegate.m
//  YTH
//
//  Created by Yousra Kamoona on 7/6/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Review.h"
#import "SettingsViewController.h"
#import "HomeViewController.h"
#import "Question.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Reviews registerSubclass];
    [Question registerSubclass];
    [Parse setApplicationId:@"etnunWd99CG1ggz72ZjYpKNIoIcPLFtFf51gxBcn"
                  clientKey:@"6gejCFInUgfohxJJUMuW14z0wz3GFDPE9PNeGaNt"];
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] incrementKey:@"RunCount"];
    [[PFUser currentUser] saveInBackground];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNVC.navigationBar.tintColor = [UIColor whiteColor];
    homeNVC.navigationBar.translucent = NO;
    //homeNVC.navigationBar.barTintColor = [UIColor colorWithRed:0.973 green:0.243 blue:0.502 alpha:1.0];
    
    NSDictionary *titleTextAttributes =
    @{
      //NSFontAttributeName : [UIFont boldSystemFontOfSize:22],
      NSForegroundColorAttributeName : [UIColor whiteColor],
      };
    
    homeNVC.navigationBar.titleTextAttributes = titleTextAttributes;
    
    self.window.rootViewController = homeNVC;
    [homeNVC setNavigationBarHidden:YES animated:NO];
    
    self.window.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:44.0/255.0 blue:27.0/255.0 alpha:1.0];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
