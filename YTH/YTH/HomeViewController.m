//
//  HomeViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "HomeViewController.h"
#import "ClinicsViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) ClinicsViewController *clinicsVC;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *clincsTapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *clinicsView;

@property (nonatomic, assign) BOOL isPresenting;

- (IBAction)onClincsButtonTapped:(id)sender;

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES];
}

#pragma GestureRecongnizers

- (void)setupGestureRecognizers {

    //clinicsTapGestureRecognizer
    self.clincsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClincsTapGesture:)];
}

#pragma GesturesSelectors 

- (IBAction)handleClincsTapGesture:(UITapGestureRecognizer *)clincsTapGestureRecognizer {
    self.clinicsVC.modalPresentationStyle = UIModalPresentationCustom;
    self.navigationController.transitioningDelegate = self;
    [self.navigationController pushViewController:self.clinicsVC animated:YES];
    
    //self.clinicsVC.transitioningDelegate = self;
    //[self presentViewController:self.clinicsVC animated:YES completion:nil];
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
@end
