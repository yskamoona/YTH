//
//  HomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "PlacesViewController.h"
#import "SettingsViewController.h"
#import "TableViewCell.h"
#import "GuidesViewController.h"
#import "NSDate+TimeAgo.h"
<<<<<<< HEAD
#import "QuestionsViewController.h"

=======
#import "LocationSettingViewController.h"
>>>>>>> 9d45ac955bd3abf1be6c44a0944c1d6dd24b6c33

typedef enum {
    latest,
    trending,
    pinned
} buttonAssociation;

const CGFloat widthConstraintMax = 320;

@interface HomeViewController ()

@property (strong, nonatomic) PlacesViewController *placesVC;
@property (weak, nonatomic  ) IBOutlet UIView *clinicsView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *clincsTapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *questionsTapGestureRecognizer;

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
- (IBAction)onGuidesButton:(id)sender;
- (IBAction)onClinicsButton:(UITapGestureRecognizer *)sender;
<<<<<<< HEAD
- (IBAction)onQuestionsViewTapped:(id)sender;
=======

// Settings Panel
- (IBAction)onDismissMenuSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)onDismissMenuTap:(UITapGestureRecognizer *)sender;
@property (assign) BOOL menuIsOpen;
@property (strong, nonatomic) IBOutlet UIView *menuDismissView;
>>>>>>> 9d45ac955bd3abf1be6c44a0944c1d6dd24b6c33

// Questions Area
@property (strong, nonatomic) IBOutlet UIView *questionsAreaView;
@property (strong, nonatomic) IBOutlet UIView *buttonBackgroundView;
- (IBAction)onLatestButton:  (UIButton *)sender;
- (IBAction)onTrendingButton:(UIButton *)sender;
- (IBAction)onPinnedButton:  (UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITableView *latestTableView;
@property (strong, nonatomic) IBOutlet UITableView *trendingTableView;
@property (strong, nonatomic) IBOutlet UITableView *pinnedTableView;
@property (strong, atomic) NSArray* fakeLatestData;

@end

@implementation HomeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestureRecognizers];
    [self setupTableViews];
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

- (void)addLocationViewToHomeView:(LocationSettingViewController *)locationSettingsView fromSettingVC:(SettingsViewController *)settingVC {
    //[self.mainView addSubview:locationSettingsView];
    [self.navigationController pushViewController:locationSettingsView animated:YES];
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
    // Create translation transform
    CATransform3D translate = CATransform3DIdentity;
    translate = CATransform3DTranslate(translate, 160.0, 0, 200.0);
    
    // Create perspective transform
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -800.0; //perspective
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI * 0.25, 0, -160, 0);
    
    self.settingVC = [[SettingsViewController alloc] init];
    self.settingVC.delegate = self;
    [self.settingsView addSubview:self.settingVC.view];
    
    if(!self.menuIsOpen) {
        [UIView animateWithDuration:0.5 animations:^{
            self.containerView.alpha = 0.7;
            self.containerView.layer.transform = CATransform3DConcat(rotationAndPerspectiveTransform, translate);
            //Bring in menu
        } completion:^(BOOL finished){
            self.menuIsOpen = YES;
            [self menuExitToggle];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.containerView.alpha = 1.0;
            self.containerView.layer.transform = CATransform3DIdentity; //remove the transforms
            //Dismiss menu
        } completion:^(BOOL finished) {
            self.menuIsOpen = NO;
            [self menuExitToggle];
        }];
    }
    self.settingsView.frame = CGRectMake(0, 70, 125, 130);
}

-(void)menuExitToggle {
    if(self.menuIsOpen) {
        self.menuDismissView.hidden = NO;
        self.menuDismissView.userInteractionEnabled = YES;
        
        self.settingsView.hidden = NO;
        self.settingsView.userInteractionEnabled = YES;
        
    } else {
        self.menuDismissView.hidden = YES;
        self.menuDismissView.userInteractionEnabled = NO;
        
        self.settingsView.hidden = YES;
        self.settingsView.userInteractionEnabled = NO;
    }
}

- (IBAction)onDismissMenuSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.state == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"dismissed");
        [self onSettingsButtonTapped:sender];
    } else {
        NSLog(@"Other way!");
    }
}

- (IBAction)onDismissMenuTap:(UITapGestureRecognizer *)sender {
    NSLog(@"dismissed");
    [self onSettingsButtonTapped:sender];
}

// On question button [[here]]

- (IBAction)onGuidesButton:(id)sender {
    GuidesViewController *guidesVC = [[GuidesViewController alloc] init];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:guidesVC animated:YES];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

- (IBAction)onClinicsButton:(UITapGestureRecognizer *)sender {
    PlacesViewController *clinicsVC = [[PlacesViewController alloc] init];
    [self presentViewController:clinicsVC animated:YES
                     completion:nil];
}

- (IBAction)onQuestionsViewTapped:(id)sender {
    QuestionsViewController *questionVC = [[QuestionsViewController alloc] init];
    [self presentViewController:questionVC
                       animated:YES
                     completion:nil];
}


- (IBAction)onLatestButton:(UIButton *)sender {
    sender.tag = latest;
    [self positionButtonBackground:sender];
    [self setActiveTable:sender];
}

- (IBAction)onTrendingButton:(UIButton *)sender {
    sender.tag = trending;
    [self positionButtonBackground:sender];
    [self setActiveTable:sender];
}

- (IBAction)onPinnedButton:(UIButton *)sender {
    sender.tag = pinned;
    [self positionButtonBackground:sender];
    [self setActiveTable:sender];
}

-(void)positionButtonBackground:(UIButton *)sender {
    [UIView animateWithDuration:.3
                          delay:0
         usingSpringWithDamping:8
          initialSpringVelocity:18
                        options:0
                     animations:^{
        self.buttonBackgroundView.frame = sender.frame;
    }
                     completion:^(BOOL finished) {
        //nil
    }];
}

-(void)setupTableViews {
    self.latestTableView.backgroundColor   = [UIColor colorWithWhite:1 alpha:.2];
    self.trendingTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:.2];
    self.pinnedTableView.backgroundColor   = [UIColor colorWithWhite:1 alpha:.2];
    
    [self.latestTableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.trendingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.pinnedTableView   setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.latestTableView.delegate     = self;
    self.latestTableView.dataSource   = self;
    self.trendingTableView.delegate   = self;
    self.trendingTableView.dataSource = self;
    self.pinnedTableView.delegate     = self;
    self.pinnedTableView.dataSource   = self;
    
    
    self.fakeLatestData = @[
                            @{@"question":@"In publishing and graphic design, lorem ipsum is a filler text commonly used to demonstrate the graphic elements of a document or visual presentation.", @"location":@"San Francisco", @"answers":@2, @"time":@"2014-07-19T21:00:30.263Z"},
                            @{@"question":@"The human immunodeficiency virus (HIV) is a lentivirus (a subgroup of retrovirus) that causes the acquired immunodeficiency syndrome (AIDS),[1][2] a condition in humans in which progressive failure of the immune system allows life-threatening opportunistic infections and cancers to thrive.", @"location":@"Los Angeles", @"answers":@0, @"time":@"2014-07-19T12:00:30.263Z"},
                            @{@"question":@"Can you get an STI from oral sex if one person has a fever blister? Also, if a person has an STI, is oral sex still OK?", @"location":@"Oakland", @"answers":@1, @"time":@"2014-07-19T23:00:30.263Z"},
                            @{@"question":@"tim", @"location":@"San Francisco", @"answers":@2, @"time":@"2014-06-19T21:00:30.263Z"},
                            @{@"question":@"jim", @"location":@"San Francisco", @"answers":@2, @"time":@162010},
                            @{@"question":@"sam", @"location":@"San Francisco", @"answers":@2, @"time":@162050},
                            @{@"question":@"In publishing and graphic design, lorem ipsum is a filler text commonly used to demonstrate the graphic elements of a document or visual presentation.", @"location":@"San Francisco", @"answers":@2, @"time":@"2014-07-19T21:00:30.263Z"},
                            @{@"question":@"The human immunodeficiency virus (HIV) is a lentivirus (a subgroup of retrovirus) that causes the acquired immunodeficiency syndrome (AIDS),[1][2] a condition in humans in which progressive failure of the immune system allows life-threatening opportunistic infections and cancers to thrive.", @"location":@"Los Angeles", @"answers":@0, @"time":@162000134},
                            @{@"question":@"Can you get an STI from oral sex if one person has a fever blister? Also, if a person has an STI, is oral sex still OK?", @"location":@"Oakland", @"answers":@1, @"time":@16200131}
                            ];
    
    [self.latestTableView   registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];
    [self.trendingTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];
    [self.pinnedTableView   registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

}

-(void)setActiveTable:(UIButton *)sender {
    [UIView animateWithDuration:.3 animations:^{
        switch (sender.tag) {
            case latest:
                self.latestTableView.center = CGPointMake(self.view.window.center.x, self.latestTableView.center.y);
                self.latestTableView.alpha = 1;
                self.trendingTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width, self.trendingTableView.center.y);
                self.pinnedTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width*2, self.pinnedTableView.center.y);
                break;
            case trending:
                self.latestTableView.center = CGPointMake(self.view.window.center.x - self.view.frame.size.width, self.latestTableView.center.y);
                self.trendingTableView.center = CGPointMake(self.view.window.center.x, self.trendingTableView.center.y);
                self.trendingTableView.alpha = 1;
                self.pinnedTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width, self.pinnedTableView.center.y);
                break;
            case pinned:
                self.latestTableView.center = CGPointMake(self.view.window.center.x - self.view.frame.size.width*2, self.latestTableView.center.y);
                self.trendingTableView.center = CGPointMake(self.view.window.center.x - self.view.frame.size.width, self.trendingTableView.center.y);
                self.pinnedTableView.center = CGPointMake(self.view.window.center.x, self.pinnedTableView.center.y);
                self.pinnedTableView.alpha = 1;
                break;
                
            default:
                break;
        }
    } completion:^(BOOL finished) {
        switch (sender.tag) {
            case latest:
                self.trendingTableView.alpha = 0;
                self.pinnedTableView.alpha = 0;
                break;
            case trending:
                self.latestTableView.alpha = 0;
                self.pinnedTableView.alpha = 0;
                break;
            case pinned:
                self.latestTableView.alpha = 0;
                self.trendingTableView.alpha = 0;
                break;
                
            default:
                break;
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.latestTableView) {
        TableViewCell *cell = [self.latestTableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        cell.questionLabel.text = self.fakeLatestData[indexPath.row][@"question"];
        cell.locationLabel.text = self.fakeLatestData[indexPath.row][@"location"];
        //'Number of answers' conditional formatting
        if (self.fakeLatestData[indexPath.row][@"answers"] == [NSNumber numberWithInteger:1]) {
            NSString *answerString = [NSString stringWithFormat:@"%@ answer",self.fakeLatestData[indexPath.row][@"answers"]];
            cell.answerLabel.text = answerString;
        } else {
            NSString *answerString = [NSString stringWithFormat:@"%@ answers",self.fakeLatestData[indexPath.row][@"answers"]];
            cell.answerLabel.text = answerString;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        NSDate *dateString = [NSDate dateWithTimeIntervalSinceNow:([self.fakeLatestData[indexPath.row][@"time"] floatValue])];
        NSString *ago = [dateString timeAgo];
        cell.timeLabel.text = ago;
        

        // This should probably go somewhere else... ?
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    } else if (tableView == self.trendingTableView) {
        TableViewCell *cell = [self.latestTableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        cell.questionLabel.text = self.fakeLatestData[indexPath.row][@"question"];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        UITableViewCell *cell = [self.pinnedTableView dequeueReusableCellWithIdentifier:@"TableCell"];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}


@end
