//
//  IWFindEmailViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFindEmailViewController.h"
#import "NSString+IW.h"
#import "IWToast.h"
#import "IWUserTool.h"
#import "MBProgressHUD+MJ.h"

@interface IWFindEmailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *email;

@end

@implementation IWFindEmailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    // 设置导航
    [self setupNavBar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resignAllFirstResponder];
}

- (void)resignAllFirstResponder {
    [self.email resignFirstResponder];
}

/**
 *  设置导航
 */
- (void)setupNavBar {
    self.title = NSLocalizedString(@"find_password_email", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"find_password_ok", nil) style:UIBarButtonItemStyleDone target:self action:@selector(buttonConfirm)];
}

/**
 *  执行找回
 */
- (void)buttonConfirm {
    NSString *email = self.email.text;
    // 判断邮箱
    if([self checkValideWithName:email error:@"please_input_email"]) return;
    if (![NSString validateEmail:self.email.text]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_email_error", nil)];
        return;
    }
    
    // 执行找回
    IWFindPasswordEmailParam *param = [[IWFindPasswordEmailParam alloc] init];
    param.mail = email;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"send_email_loading", nil)];
    [IWUserTool userFindPasswordEmailWithParam:param success:^(IWFindPasswordResult *result) {
        if (result.code == 0) {
            [MBProgressHUD hideHUD];
            // 跳转到首页
            [self dismissViewControllerAnimated:YES completion:^{
                // 发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"emailSuccess" object:self];
            }];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
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
