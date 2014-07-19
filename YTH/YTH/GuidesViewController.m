//
//  GuidesViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GuidesViewController.h"

@interface GuidesViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *guidesScroll;
@property (weak, nonatomic) IBOutlet UIView *guidesTitles;

@end

@implementation GuidesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onCloseButtonTapped:(id)sender {
       [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.guidesScroll.contentSize = self.guidesTitles.frame.size;
    [self.guidesScroll setScrollEnabled:true];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
