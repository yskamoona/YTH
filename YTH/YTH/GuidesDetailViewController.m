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
#import "UIColor+YTH.h"
#import "GuideQuestions.h"

@interface GuidesDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *detailGuides;
@property (strong, nonatomic) NSMutableDictionary *collapsed;
@property (nonatomic, assign) BOOL animateOnTableReload;

- (IBAction)onHomeButton:(id)sender;

@end

@implementation GuidesDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //Load LatestData
        PFQuery *query = [GuideQuestions query];
        [query orderByDescending:@"createdAt"];
        [query whereKey:@"parent" containsString:@"OxpZsynQHz"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.detailGuides = objects;
                //NSLog(@"got question %@", self.detailGuides);
                [self.tableView reloadData];
                if (self.animateOnTableReload == YES) {
                    // now animate top cell
                   // [self animateTopCell];
                }
                self.animateOnTableReload = NO;
                
            }
            
        }];

//        self.detailGuides = @[@"Intro text here",@"Should I get tested for STDs?",@"How do I get tested for STDs?",@"Where can I get an STD test?",@"Which STD tests do I need?",@"How are STD tests done?",@"Do People under 18 need their parents' permission for STD testing?"];
    }
    return self;
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
    
    self.collapsed = [NSMutableDictionary dictionary];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.detailGuides.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collapsed[@(section)] boolValue] ? 2 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuidesDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"GuidesDetailTableViewCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        //question cell
        GuideQuestions *gq = self.detailGuides[0];
        cell.detailCell.text = gq.question;
        cell.detailCell.layer.backgroundColor = [UIColor YTHGPinkColor].CGColor;

    } else
        //answers cell
        cell.detailCell.text = @"";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 40;
    } else
        return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //dont do anything
    } else {
        self.collapsed[@(indexPath.section)] = @(![self.collapsed [@(indexPath.section)] boolValue]);
         [self.tableView reloadData];
    }
   
}

- (IBAction)onHomeButton:(id)sender{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [[self navigationController] setNavigationBarHidden:YES];
    [self.navigationController pushViewController:homeVC animated:YES];
}


@end
