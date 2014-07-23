//
//  STDsViewController.m
//  YTH
//
//  Created by Kristina Frost on 7/19/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "STDsViewController.h"
#import "HomeViewController.h"
#import "STDsTableViewCell.h"
#import "GuidesDetailViewController.h"

@interface STDsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *subGuides;
- (IBAction)onHomeButton:(id)sender;


@end

@implementation STDsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.subGuides = @[@"Safer Sex ('Safe Sex')",@"The Check",@"STD Testing",@"Chancroid",@"Chlamydia",@"Genital Warts",@"Gonorrhea",@"Hepatitis B",@"Herpes",@"HIV & AIDS",@"Human Papillomavirus (HPV)",@"Molluscum Contagiosum",@"Pelvic Inflammatory Disease (PID)",@"Public Lice",@"Scabies",@"Syphilis",@"Trichomoniasis (Trich)"];
        
        
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"you tapped");
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GuidesDetailViewController *guidesDetailVC = [[GuidesDetailViewController alloc] init];
   
    [self.navigationController pushViewController:guidesDetailVC animated:YES];
    guidesDetailVC.navigationItem.title = self.subGuides[indexPath.row];
   
    
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
    
    UINib *nib = [UINib nibWithNibName:@"STDsTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"STDsTableViewCell"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STDsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"STDsTableViewCell" forIndexPath:indexPath];
    
    cell.stdCellName.text = self.subGuides[indexPath.row];
    
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subGuides.count;
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
