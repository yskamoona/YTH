//
//  HomeMainContentViewController.m
//  YTH
//
//  Created by Yousra Kamoona on 7/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "HomeMainContentViewController.h"
#import "PlacesViewController.h"
#import "GuidesViewController.h"
#import "QuestionsViewController.h"

@interface HomeMainContentViewController ()

@property (weak, nonatomic) IBOutlet UIView *clinicsView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *clincsTapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *guidesTapGestureRecongnizer;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *questionsTapGestureRecognizer;

@property (nonatomic, assign) BOOL isPresenting;

@end

@implementation HomeMainContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma GestureRecongnizers

- (void)setupGestureRecognizers {
    
    //clinicsTapGestureRecognizer
    self.clincsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClincsTapGesture:)];
    //guidesTapGestureRecongnizer
    self.guidesTapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGuidesTapGestureRecognizer:)];
    //questionsTapGestureRecongnizer
    self.questionsTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleQuestionsTapGestureRecognizer:)];
}

#pragma GesturesSelectors

- (IBAction)handleClincsTapGesture:(UITapGestureRecognizer *)clincsTapGestureRecognizer {
   
    PlacesViewController *clinicsVC = [[PlacesViewController alloc] init];
    clinicsVC.modalPresentationStyle = UIModalPresentationCustom;
    clinicsVC.navigationController.transitioningDelegate = self;
    //[self.navigationController pushViewController:clinicsVC animated:YES];
    
   // clinicsVC.transitioningDelegate = self;
    [self presentViewController:clinicsVC animated:YES completion:nil];
}

- (IBAction)handleGuidesTapGestureRecognizer:(id)sender {
    GuidesViewController *guidesVC = [[GuidesViewController alloc] init];
    [self presentViewController:guidesVC animated:YES
                     completion:nil];
}


- (IBAction)handleQuestionsTapGestureRecognizer:(id)sender {
    QuestionsViewController *questionsVC = [[QuestionsViewController alloc] init];
    [self presentViewController:questionsVC animated:YES
                     completion:nil];
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
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    if (self.isPresenting) {
        toViewController.view.frame = containerView.frame;
        [containerView addSubview:toViewController.view];
        
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
