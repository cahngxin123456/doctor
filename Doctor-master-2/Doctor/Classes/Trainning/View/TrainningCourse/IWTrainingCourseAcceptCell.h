//
//  IWTrainingCourseAcceptCell.h
//  Conedot
//
//  Created by 范超 on 16/7/10.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWCourse, IWTrainningCourseViewController;

@interface IWTrainingCourseAcceptCell : UITableViewCell
@property (nonatomic, strong) IWCourse *course;
@property (nonatomic, weak) IWTrainningCourseViewController *vc;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
