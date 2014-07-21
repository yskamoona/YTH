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
#import "QuestionsViewController.h"
#import "LocationSettingViewController.h"
#import "MyReviewsViewController.h"
#import "FavoriteGuidesViewController.h"
#import <Parse/Parse.h>
#import "Question.h"
#import "UIColor+YTH.h"
#import "QuestionDetailsViewController.h"

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
@property (strong, nonatomic) SettingsViewController *settingVC;

@property (strong, nonatomic) IBOutlet UIView *otherOptionsView;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *settingsView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (strong, nonatomic) QuestionsViewController *questionsVC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewWidthConstraint;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *containerViewPanGestureRecognizer;

@property (assign) NSInteger changingPosX;

// Header area
@property (strong, nonatomic) IBOutlet UIView *questionButtonView;
@property (strong, nonatomic) IBOutlet UIView *clinicButtonView;
@property (strong, nonatomic) IBOutlet UIView *guideButtonVIew;

- (IBAction)onQuestionButton:(UITapGestureRecognizer *)sender;
- (IBAction)onClinicsButton: (UITapGestureRecognizer *)sender;
- (IBAction)onGuidesButton:  (id)sender;


// Settings Panel
- (IBAction)onSettingsButtonTapped:    (id)sender;
- (IBAction)onDismissMenuSwipe:        (UISwipeGestureRecognizer *)sender;
- (IBAction)onDismissMenuTap:          (UITapGestureRecognizer *)sender;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *dismissMenuSwipe;
@property (strong, nonatomic) IBOutlet UIView *menuDismissView;
@property (strong, nonatomic) IBOutlet UIView *settingsBackgroundTintView;
@property (assign) BOOL menuIsOpen;

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

@property (strong, nonatomic) NSArray *latestData;
@property (strong, nonatomic) NSArray *trendingData;
@property (strong, nonatomic) NSArray *ythPinnedData;


@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDataForTableViews];

    [self setupTableViews];
    [self setupSettingsMenu];
    [self.containerView addSubview:self.otherOptionsView];
    //adjuste its subviews with it
    self.containerView.clipsToBounds = YES;
    self.otherOptionsView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
}

- (void)loadDataForTableViews {
    
    //Load LatestData
    PFQuery *query = [Question query];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.LatestData = objects;
            NSLog(@"got question %@", self.latestData);
            [self.latestTableView reloadData];
        }
    }];
    
    //Load TrendingData
    PFQuery *queryForTrending = [Question query];
    [queryForTrending whereKey:@"trending" equalTo:[NSNumber numberWithBool:YES]];
    [queryForTrending orderByDescending:@"createdAt"];
    [queryForTrending findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.trendingData = objects;
            NSLog(@"got question %@", self.trendingData);
            [self.trendingTableView reloadData];
        }
    }];
    
    PFQuery *queryForYTHPinned = [Question query];
    [queryForYTHPinned whereKey:@"yth_pinned" equalTo:[NSNumber numberWithBool:YES]];
    [queryForYTHPinned findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.ythPinnedData = objects;
            NSLog(@"got question %@", self.ythPinnedData);
            [self.pinnedTableView reloadData];
        }
    }];
}

#pragma  AS Setting VC delegate methods

- (void)backToHomeScreenView:(HomeMainContentViewController *)homeMainContentVC fromSettingVC:(SettingsViewController *)settingVC {
    self.otherOptionsView.hidden = YES;
    [self slideBackMenu];
}

- (void)addLocationViewToHomeView:(LocationSettingViewController *)locationSettingsView fromSettingVC:(SettingsViewController *)settingVC {
    self.otherOptionsView.hidden = NO;
    [self.otherOptionsView addSubview:locationSettingsView.view];
    [self slideBackMenu];
}

- (void)addMyQuestionsViewToHomeView:(UIView *)myQestionsView fromSettingVC:(SettingsViewController *)settingVC {
    self.otherOptionsView.hidden = NO;
    [self.otherOptionsView addSubview:myQestionsView];
    [self slideBackMenu];
}

- (void)addMyReviewsViewToHomeView:(UIView *)myReviewsView fromSettingVC:(SettingsViewController *)settingVC {
    self.otherOptionsView.hidden = NO;
    [self.otherOptionsView addSubview:myReviewsView];
    [self slideBackMenu];
}

- (void)addFavoriteGuidesViewToHomeView:(UIView *)favoriteGuidesView fromSettingVC:(SettingsViewController *)settingVC {
    self.otherOptionsView.hidden = NO;
    [self.otherOptionsView addSubview:favoriteGuidesView];
    [self slideBackMenu];
}

#pragma Settings

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
            self.settingsView.transform = CGAffineTransformMakeTranslation(160, 0);
            self.containerView.alpha = 0.7;
            self.containerView.layer.transform = CATransform3DConcat(rotationAndPerspectiveTransform, translate);
            self.settingsBackgroundTintView.alpha = 0.4;
        } completion:^(BOOL finished){
            self.menuIsOpen = YES;
            [self menuExitToggle];
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.settingsView.transform = CGAffineTransformIdentity; //removes transform
            self.containerView.alpha = 1.0;
            self.containerView.layer.transform = CATransform3DIdentity; //remove the transforms
            self.settingsBackgroundTintView.alpha = 0;
        } completion:^(BOOL finished) {
            self.menuIsOpen = NO;
            [self menuExitToggle];
        }];
    }
}

//calling this whenever a setting is chosen to slide back the menu
- (void)slideBackMenu {
    [UIView animateWithDuration:0.5 animations:^{
        self.settingsView.transform = CGAffineTransformIdentity; //removes transform
        self.containerView.alpha = 1.0;
        self.containerView.layer.transform = CATransform3DIdentity; //remove the transforms
        self.settingsBackgroundTintView.alpha = 0;
    } completion:^(BOOL finished) {
        self.menuIsOpen = NO;
        [self menuExitToggle];
    }];
}

- (void)setupSettingsMenu {
    self.settingsView.frame = CGRectMake(-160, 70, 125, 130);
    self.settingsView.hidden = NO;
    self.settingsView.userInteractionEnabled = YES;
    self.dismissMenuSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
}
- (void)menuExitToggle {
    if(self.menuIsOpen) {
        self.menuDismissView.hidden = NO;
        self.menuDismissView.userInteractionEnabled = YES;
    } else {
        self.menuDismissView.hidden = YES;
        self.menuDismissView.userInteractionEnabled = NO;
    }
}
// Use touch to dismiss menu
- (IBAction)onDismissMenuSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self onSettingsButtonTapped:sender];
    }
}
- (IBAction)onDismissMenuTap:(UITapGestureRecognizer *)sender {
    [self onSettingsButtonTapped:sender];
}

- (IBAction)onQuestionButton:(UITapGestureRecognizer *)sender {
    self.questionsVC = [[QuestionsViewController alloc] init];
    self.questionsVC.delegate = self;
    [self navigationController].navigationBar.barTintColor = [UIColor YTHGreenColor];
    [self.navigationController pushViewController:self.questionsVC animated:YES];
}

- (IBAction)onClinicsButton:(UITapGestureRecognizer *)sender {
    PlacesViewController *clinicsVC = [[PlacesViewController alloc] init];
    [self navigationController].navigationBar.barTintColor = [UIColor YTHBabyBlueColor];
    [self.navigationController pushViewController:clinicsVC animated:YES];
}

- (IBAction)onGuidesButton:(id)sender {
    GuidesViewController *guidesVC = [[GuidesViewController alloc] init];
    [self navigationController].navigationBar.barTintColor = [UIColor YTHGPinkColor];
    [self.navigationController pushViewController:guidesVC animated:YES];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
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

- (void)positionButtonBackground:(UIButton *)sender {
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

- (void)setupTableViews {
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

- (void)setActiveTable:(UIButton *)sender {
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
    if (tableView == self.latestTableView) {
        return self.latestData.count;
    } else if (tableView == self.trendingTableView) {
        return self.trendingData.count;
    } else {
        return self.ythPinnedData.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.latestTableView) {
        TableViewCell *cell = [self.latestTableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        cell.questionLabel.text = [self.latestData[indexPath.row] body];
        cell.locationLabel.text = self.fakeLatestData[0][@"location"];
        //'Number of answers' conditional formatting
        if (self.fakeLatestData[0][@"answers"] == [NSNumber numberWithInteger:1]) {
            NSString *answerString = [NSString stringWithFormat:@"%@ answer",self.fakeLatestData[0][@"answers"]];
            cell.answerLabel.text = answerString;
        } else {
            NSString *answerString = [NSString stringWithFormat:@"%@ answers",self.fakeLatestData[0][@"answers"]];
            cell.answerLabel.text = answerString;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        NSDate *dateString = [NSDate dateWithTimeIntervalSinceNow:([self.fakeLatestData[0][@"time"] floatValue])];
        NSString *ago = [dateString timeAgo];
        cell.timeLabel.text = ago;
        

        // This should probably go somewhere else... ?
        // you can keep it
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    } else if (tableView == self.trendingTableView) {
        TableViewCell *cell = [self.trendingTableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        cell.questionLabel.text = [self.trendingData[indexPath.row] body];
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        TableViewCell *cell = [self.pinnedTableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
        cell.questionLabel.text = [self.ythPinnedData[indexPath.row] body];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionDetailsViewController *questionsDetailsVC = [[QuestionDetailsViewController alloc] init];
    
    if (tableView == self.latestTableView) {
        questionsDetailsVC.question = self.latestData[indexPath.row];
    } else if (tableView == self.trendingTableView) {
        questionsDetailsVC.question = self.trendingData[indexPath.row];
    } else {
        questionsDetailsVC.question = self.ythPinnedData[indexPath.row];
    }
    
    [self navigationController].navigationBar.barTintColor = [UIColor YTHGreenColor];
    [self.navigationController pushViewController:questionsDetailsVC animated:YES];
}

- (void)didAskQuestionAndDimissViewController:(QuestionsViewController *)questionsVC {
    [self loadDataForTableViews];
    [self.questionsVC dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//    
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//    
//}

#pragma mark - UIViewControllerAnimatedTransitioning Methods

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
}

@end
