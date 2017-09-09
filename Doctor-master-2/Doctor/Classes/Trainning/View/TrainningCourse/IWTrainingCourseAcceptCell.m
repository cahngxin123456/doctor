//
//  IWTrainingCourseCell.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWTrainingCourseAcceptCell.h"
#import "UIImageView+WebCache.h"
#import "IWCourse.h"
#import "IWTrainningTool.h"
#import "IWCompanyTool.h"
#import "IWFanCompany.h"
#import "MBProgressHUD+MJ.h"
#import "IWTrainningCourseViewController.h"

@interface IWTrainingCourseAcceptCell()
@property (weak, nonatomic) IBOutlet UILabel *textTitle;
@property (weak, nonatomic) IBOutlet UILabel *textOverview;
@property (weak, nonatomic) IBOutlet UILabel *textTime;
@property (weak, nonatomic) IBOutlet UIImageView *imageThumb;
@property (weak, nonatomic) IBOutlet UILabel *textClassTitle;
@property (weak, nonatomic) IBOutlet UILabel *textClassTeacher;
@property (weak, nonatomic) IBOutlet UILabel *textClassTime;
@property (weak, nonatomic) IBOutlet UILabel *textClassEndTime;
@property (weak, nonatomic) IBOutlet UILabel *textClassAddress;
@property (weak, nonatomic) IBOutlet UIButton *bAccept;

- (IBAction)buttonAccept:(id)sender;

@property (nonatomic, weak) UIView *divider;
@end

@implementation IWTrainingCourseAcceptCell

- (void)awakeFromNib {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
    
    [self.bAccept setBackgroundImage:[UIImage resizedImageWithName:@"btn_cs_normal"] forState:UIControlStateNormal];
    [self.bAccept setBackgroundImage:[UIImage resizedImageWithName:@"btn_cs_press"] forState:UIControlStateNormal];
}

/**
 *  在这个方法中设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 1;
    CGFloat dividerY = self.frame.size.height - dividerH - 10;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"course";
    IWTrainingCourseAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWTrainingCourseAcceptCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setCourse:(IWCourse *)course {
    _course = course;
    
    self.textTitle.text = course.title;
    self.textOverview.text = course.overview;
    self.textTime.text = course.insertTime;
    [self.imageThumb sd_setImageWithURL:[NSURL URLWithString:course.thumb] placeholderImage:[UIImage imageWithName:@"app_default_img"]];
    self.textClassTitle.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"trainning_course_layout_title", nil), course.classInfoTitle];
    self.textClassTeacher.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"trainning_course_teacher", nil), course.teacher];
    self.textClassTime.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"trainning_course_time", nil), [NSString stringWithFormat:@"%@", course.startTime]];
    self.textClassEndTime.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"trainning_course_end_time", nil), [NSString stringWithFormat:@"%@", course.endTime]];
    self.textClassAddress.text = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"trainning_course_address", nil), course.address];
}

- (IBAction)buttonAccept:(id)sender {
    IWJoinRefuseCourseParam *param = [[IWJoinRefuseCourseParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @([IWCompanyTool fancompany].companyId);
    param.classId = self.course.ID;
    param.type = 1;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"trainning_course_loading", nil)];
    [IWTrainningTool joinRefuseCouseWithParams:param success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"trainning_course_accept_success", nil)];
            [self.vc.header beginRefreshing];
        } else {
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:NSLocalizedString(@"trainning_course_accept_fail", nil)];
    }];
}
@end
