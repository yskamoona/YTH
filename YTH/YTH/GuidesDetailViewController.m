//
//  GuidesDetailViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "GuidesDetailViewController.h"
#import "HomeViewController.h"
#import "GuidesDetailTableViewCell.h"

@interface GuidesDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *detailGuides;

- (IBAction)onHomeButton:(id)sender;

@end

@implementation GuidesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.detailGuides = @[@"Intro text here",@"Should I get tested for STDs?",@"How do I get tested for STDs?",@"Where can I get an STD test?",@"Which STD tests do I need?",@"How are STD tests done?",@"Do People under 18 need their parents' permission for STD testing?"];
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you tapped");
     
}
     

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIImage *homeButtonImage = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *homeButton = [[UIBarButtonItem alloc] initWithImage:homeButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(onHomeButton:)];
    self.navigationItem.rightBarButtonItem = homeButton;
    
    UINib *nib = [UINib nibWithNibName:@"GuidesDetailTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"GuidesDetailTableViewCell"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GuidesDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GuidesDetailTableViewCell" forIndexPath:indexPath];
    
    cell.detailCell.text = self.detailGuides[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailGuides.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
