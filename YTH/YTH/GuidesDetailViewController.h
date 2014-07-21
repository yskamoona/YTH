//
//  GuidesDetailViewController.h
//  YTH
//
//  Created by Kristina Frost on 7/20/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidesDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end
