//
//  IWBirthdayViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBirthdayViewController.h"
#import "IWMeTool.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWToast.h"
#import "NSString+IW.h"
#import "MBProgressHUD+MJ.h"

@interface IWBirthdayViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation IWBirthdayViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置标题
    self.title = NSLocalizedString(@"setting_birthday", nil);
    
    // 设置控件初始值
    [self setupDefaultDate];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"finish", nil) style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}

/**
 * 设置控件初始值
 */
- (void)setupDefaultDate {
    NSString *defaultDate = self.sourceItem.defaultText;
    if ([defaultDate isEqualToString:@""] || defaultDate == nil) {
        return;
    }
    IWLog(@"%@", defaultDate);
    //将时间字符串转化为NSDate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSDate *date=[dateFormatter dateFromString:defaultDate];
    [self.datePicker setDate:date];
}

- (void)finish {
    IWMeParam *param = [[IWMeParam alloc] init];
    param.cellphone = [IWUserTool user].cellphone;
    param.pwd = [IWUserTool user].pwd;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    param.birthday =  [fmt stringFromDate:self.datePicker.date];
    
    [IWMeTool changeUserInfoWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 保存信息
            IWUser *user = [IWUserTool user];
            user.birthday = param.birthday;
            [IWUserTool saveUser:user];
            
            // 关闭控制器
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

@end
