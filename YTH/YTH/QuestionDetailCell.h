//
//  QuestionDetailCell.h
//  YTH
//
//  Created by Yousra Kamoona on 7/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *anwersLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
