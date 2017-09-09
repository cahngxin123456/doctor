//
//  IWPasswordViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWPasswordViewController.h"
#import "IWToast.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWMeTool.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+IW.h"

@interface IWPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwdField;
@property (weak, nonatomic) IBOutlet UITextField *newpwdField;
@property (weak, nonatomic) IBOutlet UITextField *retryPwdField;

@end

@implementation IWPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    [self setupLanguage];
    
    self.title = NSLocalizedString(@"change_password", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"finish", nil) style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}

- (void)setupLanguage {
    self.oldPwdField.placeholder = NSLocalizedString(@"changepassword_old_password", nil);
    self.newpwdField.placeholder = NSLocalizedString(@"changepassword_new_password", nil);
    self.retryPwdField.placeholder = NSLocalizedString(@"changepassword_retry_password", nil);
}

- (void)finish {
    NSString *oldPwd = self.oldPwdField.text;
    NSString *newPwd = self.newpwdField.text;
    NSString *retryPwd = self.retryPwdField.text;
    
    // 判断密码
    if([self checkValideWithName:oldPwd error:@"please_input_password"]) return;
    NSString *real_old = [IWUserTool user].pwd;
    if (![real_old isEqualToString:[NSString md5:oldPwd]]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"old_password_error", nil)];
        return;
    }
    
    if([self checkValideWithName:newPwd error:@"please_input_newpassword"]) return;
    
    if (![retryPwd isEqualToString:newPwd]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"confirm_password_error", nil)];
        return;
    }
    
    // 发送请求
    IWChangePasswordParam *param = [[IWChangePasswordParam alloc] init];
    param.cellphone = [IWUserTool user].cellphone;
    param.pwd = [IWUserTool user].pwd;
    param.pwdNew = retryPwd;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"change_userinfo_loading", nil)];
    [IWMeTool changePasswordInfoWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 保存信息
            IWUser *user = [IWUserTool user];
            user.pwd = [NSString md5:param.pwdNew];
            user.password = retryPwd;
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

/**
 *  检查输入字符的合法性
 *
 *  @param name  输入字符
 *  @param error 错误显示
 *
 *  @return true：非法
 */
- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error{
    if (name == nil || [name isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        return YES;
    }
    return NO;
}
@end
