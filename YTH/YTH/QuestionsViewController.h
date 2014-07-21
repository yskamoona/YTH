//
//  QuestionsViewController.h
//  YTH
//
//  Created by Yousra Kamoona on 7/16/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionsViewControllerDelegate;

@interface QuestionsViewController : UIViewController

@property (weak, nonatomic) id <QuestionsViewControllerDelegate> delegate;

@end

@protocol QuestionsViewControllerDelegate <NSObject>

@required
- (void)didAskQuestionAndDimissViewController:(QuestionsViewController *)questionsVC;

@end


