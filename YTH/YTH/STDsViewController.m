//
//  STDsViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "STDsViewController.h"
#import "HomeViewController.h"

@interface STDsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onHomeButton:(id)sender;


@end

@implementation STDsViewController

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
    self.navigationItem.title = @"STDs";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIImage *homeButtonImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onHomeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 17;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = [NSString stringWithFormat:@"this is row %d", indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
