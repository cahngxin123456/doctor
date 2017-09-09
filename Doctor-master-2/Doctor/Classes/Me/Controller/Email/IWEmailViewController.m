//
//  IWEmailViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWEmailViewController.h"
#import "IWMeTool.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWToast.h"
#import "NSString+IW.h"
#import "MBProgressHUD+MJ.h"
#import "IWTextField.h"

@interface IWEmailViewController ()
@property (weak, nonatomic) IBOutlet IWTextField *emailField;

@end

@implementation IWEmailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    self.title = NSLocalizedString(@"setting_email", nil);
    
    // 设置初始值
    NSString *text = @"";
    if ((NSNull *)self.sourceItem.defaultText == [NSNull null] || [self.sourceItem.defaultText isEqualToString:@""]) {
        text = @"";
    } else {
        text = self.sourceItem.defaultText;
    }
    if (![text isEqualToString:@""]) {
        self.emailField.text = self.sourceItem.defaultText;
    } else {
        self.emailField.placeholder = NSLocalizedString(@"person_email", nil);
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"finish", nil) style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}

- (void)finish {
    if ([self.emailField.text isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_email", nil)];
        return;
    }
    
    if (![NSString validateEmail:self.emailField.text]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_email_error", nil)];
        return;
    }
    
    IWMeParam *param = [[IWMeParam alloc] init];
    param.cellphone = [IWUserTool user].cellphone;
    param.pwd = [IWUserTool user].pwd;
    param.mail = self.emailField.text;
    [MBProgressHUD showMessage:NSLocalizedString(@"change_userinfo_loading", nil)];
    [IWMeTool changeUserInfoWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 保存信息
            IWUser *user = [IWUserTool user];
            user.mail = param.mail;
            [IWUserTool saveUser:user];

            // 关闭控制器
            [self.navigationController popViewControllerAnimated:YES];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

@end
