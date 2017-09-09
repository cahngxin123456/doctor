//
//  IWTrainingCourseCell.h
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWCourse;

@interface IWTrainingCourseCell : UITableViewCell
@property (nonatomic, strong) IWCourse *course;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
