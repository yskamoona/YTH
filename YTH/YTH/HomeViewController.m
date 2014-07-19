//
//  HomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "ClinicsViewController.h"
#import "SettingsViewController.h"
#import "TableViewCell.h"

typedef enum {
    latest,
    trending,
    pinned
} buttonAssociation;

@interface HomeViewController ()

@property (strong, nonatomic) ClinicsViewController  *clinicsVC;
@property (weak, nonatomic  ) IBOutlet UIView *containerView;
@property (weak, nonatomic  ) IBOutlet UIView *settingsView;

@property (weak, nonatomic  ) IBOutlet UIView *clinicsView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *clincsTapGestureRecognizer;

@property (nonatomic, assign) BOOL isPresenting;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidthConstraint;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *containerViewPanGestureRecognizer;
@property (assign) NSInteger changingPosX;

- (IBAction)onClincsButtonTapped:(id)sender;
- (IBAction)onSettingsButtonTapped:(id)sender;


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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.clinicsVC = [[ClinicsViewController alloc] init];
    }
    return self;
}

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

    //clinicsTapGestureRecognizer
    self.clincsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClincsTapGesture:)];
    
    //containerViewPanGestureRecognizer
    self.containerViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGestureForMainView:)];
    [self.containerView addGestureRecognizer:self.containerViewPanGestureRecognizer];
}

#pragma GesturesSelectors 

- (void)onPanGestureForMainView:(UIPanGestureRecognizer *)panGestureOnMainView {
    self.changingPosX = [panGestureOnMainView translationInView:self.view].x;
    NSLog(@"Traslation in view.x %ld", (long)self.changingPosX);
    
    self.containerViewWidthConstraint.constant = 320 - self.changingPosX;
    self.changingPosX = MIN(self.changingPosX, 260);
    self.changingPosX = MAX(self.changingPosX, 0);
    
    NSLog(@"New Pos %ld", (long)self.changingPosX);
    
    if (panGestureOnMainView.state == UIGestureRecognizerStateEnded) {
        if (self.changingPosX >= 150) {
            [UIView animateWithDuration:.2 animations:^{
                self.containerViewWidthConstraint.constant = 60;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
            
        } else {
            [UIView animateWithDuration:.2 animations:^{
                self.containerViewWidthConstraint.constant = 320;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
    [self.view updateConstraints];
    
}

- (IBAction)handleClincsTapGesture:(UITapGestureRecognizer *)clincsTapGestureRecognizer {
    self.clinicsVC.modalPresentationStyle = UIModalPresentationCustom;
    self.clinicsVC.navigationController.transitioningDelegate = self;
    //[self.navigationController pushViewController:self.clinicsVC animated:YES];
    
    self.clinicsVC.transitioningDelegate = self;
    [self presentViewController:self.clinicsVC animated:YES completion:nil];
}


#pragma UIViewControllerTransitioningDelegate Methods

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresenting = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismisses {
    self.isPresenting = NO;
    return self;
}

//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
//
//}
//
//- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
//
//}

#pragma UIViewControllerAnimatedTransitioningDelegate Methods

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.clinicsView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.isPresenting) {
        toViewController.view.frame = self.clinicsView.frame;
        [self.clinicsView addSubview:toViewController.view];
        
        toViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        
        [UIView animateWithDuration:2.0 animations:^{
            toViewController.view.alpha = 1;
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);

        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
            [UIView animateWithDuration:2.0 animations:^{
                fromViewController.view.alpha = 0;
                fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
           } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }

}

#pragma IBActions

- (IBAction)onClincsButtonTapped:(id)sender {
    
}

- (IBAction)onSettingsButtonTapped:(id)sender {
    SettingsViewController *settingVC = [[SettingsViewController alloc] init];
    [self.settingsView addSubview:settingVC.view];
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
 
    
    self.latestTableView.delegate     = self;
    self.latestTableView.dataSource   = self;
    self.trendingTableView.delegate   = self;
    self.trendingTableView.dataSource = self;
    self.pinnedTableView.delegate     = self;
    self.pinnedTableView.dataSource   = self;
    
    
    self.fakeLatestData = @[
                            @{@"question":@"In publishing and graphic design, lorem ipsum is a filler text commonly used to demonstrate the graphic elements of a document or visual presentation.", @"location":@25, @"answers":@2, @"time":@162000},
                            @{@"question":@"The human immunodeficiency virus (HIV) is a lentivirus (a subgroup of retrovirus) that causes the acquired immunodeficiency syndrome (AIDS),[1][2] a condition in humans in which progressive failure of the immune system allows life-threatening opportunistic infections and cancers to thrive.", @"location":@25, @"answers":@0, @"time":@162000},
                            @{@"question":@"tim", @"location":@25, @"answers":@1, @"time":@162000},
                            @{@"question":@"tim", @"location":@25, @"answers":@2, @"time":@162000},
                            @{@"question":@"tim", @"location":@25, @"answers":@2, @"time":@162000},
                            @{@"question":@"tim", @"location":@25, @"answers":@2, @"time":@162000},
                            ];
    

    
    [self.latestTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];
    [self.trendingTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];
    [self.pinnedTableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableCell"];

}

-(void)setActiveTable:(UIButton *)sender {
    [UIView animateWithDuration:.3 animations:^{
        switch (sender.tag) {
            case latest:
                NSLog(@"one");
                self.latestTableView.center = CGPointMake(self.view.window.center.x, self.latestTableView.center.y);
                self.latestTableView.alpha = 1;
                self.trendingTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width, self.trendingTableView.center.y);
//                self.trendingTableView.alpha = 0;
                self.pinnedTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width*2, self.pinnedTableView.center.y);
                break;
            case trending:
                NSLog(@"two");
                self.latestTableView.center = CGPointMake(self.view.window.center.x - self.view.frame.size.width, self.latestTableView.center.y);
//                self.latestTableView.alpha = 0;
                self.trendingTableView.center = CGPointMake(self.view.window.center.x, self.trendingTableView.center.y);
                self.trendingTableView.alpha = 1;
                self.pinnedTableView.center = CGPointMake(self.view.window.center.x + self.view.frame.size.width, self.pinnedTableView.center.y);
                break;
            case pinned:
                NSLog(@"three");
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
                NSLog(@"one");
                //self.latestTableView.alpha = 1;
                self.trendingTableView.alpha = 0;
                self.pinnedTableView.alpha = 0;
                break;
            case trending:
                NSLog(@"two");
                self.latestTableView.alpha = 0;
                //self.trendingTableView.alpha = 1;
                self.pinnedTableView.alpha = 0;
                break;
            case pinned:
                NSLog(@"three");
                //self.latestTableView.alpha = 0;
                self.trendingTableView.alpha = 0;
                self.pinnedTableView.alpha = 1;
                break;
                
            default:
                break;
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.latestTableView) {
        return 5;
    }
    else if (tableView == self.trendingTableView) {
        return 5;
    }
    else {
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.latestTableView) {
        return 100;
    }
    else if (tableView == self.trendingTableView) {
        return 100;
    }
    else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.latestTableView) {
        UITableViewCell *cell = [self.latestTableView dequeueReusableCellWithIdentifier:@"TableCell"];
        
        //cell.questionLabel.text = self.fakeLatestData[indexPath.row][@"question"];
        return cell;
    } else if (tableView == self.trendingTableView) {
         UITableViewCell *cell = [self.trendingTableView dequeueReusableCellWithIdentifier:@"TableCell"];
        return cell;
    } else {
        UITableViewCell *cell = [self.pinnedTableView dequeueReusableCellWithIdentifier:@"TableCell"];
        return cell;
    }
}

//- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [self.latestTableView cellForRowAtIndexPath:indexPath];
//    return cell;
//}

@end
