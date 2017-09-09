//
//  IWUserLoginViewController.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWUserLoginViewController.h"
#import "IWTabBarViewController.h"
#import "IWNavigationController.h"
#import "IWUserRegisterViewController.h"
#import "IWForgetViewController.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "IWUserTool.h"
#import "IWUser.h"

@interface IWUserLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (weak, nonatomic) IBOutlet UIButton *buttonForget;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

- (IBAction)buttonLogin:(id)sender;
- (IBAction)buttonRegister:(id)sender;
- (IBAction)buttonForget:(id)sender;
@end

@implementation IWUserLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏属性
    [self setupNavBar];
    
    // 设置登录控件的属性
    [self setupBg];
    
    // 注册监听
    [self registerNotice];
    
    // 是否自动登录
    [self autoLogin];
}

/**
 *  注册监听
 */
- (void)registerNotice {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(showEmailSuccess) name:@"emailSuccess" object:nil];
}

- (void)showEmailSuccess {
    [IWToast toastWithView:self.view title:NSLocalizedString(@"send_email_success", nil)];
}

/**
 *  是否自动登录
 */
- (void)autoLogin {
    if (self.user) {
        self.textPhone.text = self.user.cellphone;
        self.textPassword.text = self.user.password;
        
        [self buttonLogin:nil];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resignAllFirstResponder];
}

- (void)resignAllFirstResponder {
    [self.textPhone resignFirstResponder];
    [self.textPassword resignFirstResponder];
}

/**
 *  设置登录控件的属性
 */
- (void)setupBg {
    // 外边框
    [self.imageLogin setImage:[UIImage resizedImageWithName:@"bg_login_inputView"]];
    // 文字国际化
    [self.textPhone setPlaceholder:NSLocalizedString(@"cellphone", nil)];
    [self.textPassword setPlaceholder:NSLocalizedString(@"password", nil)];
    [self.buttonForget setTitle:NSLocalizedString(@"forget_password", nil) forState:UIControlStateNormal];
    [self.buttonRegister setTitle:NSLocalizedString(@"register_now", nil) forState:UIControlStateNormal];
    [self.buttonLogin setTitle:NSLocalizedString(@"login_now", nil) forState:UIControlStateNormal];
    
    // 按钮
    [self.buttonLogin setBackgroundImage:[UIImage resizedImageWithName:@"btn_green"] forState:UIControlStateNormal];
    [self.buttonLogin setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_highlighted"] forState:UIControlStateHighlighted];
    [self.buttonLogin setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_disabled"] forState:UIControlStateDisabled];
    
    // 注册事件
    [self.textPassword setDelegate:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

/**
 *  设置导航栏属性
 */
- (void)setupNavBar {
    self.view.backgroundColor = IWLoginBg;
    self.labelView.text = NSLocalizedString(@"login", nil);
    [self.bannerView setBackgroundColor:IWColor(248, 250, 251)];
    
    // 设置手机号
    if (self.cellphone) {
        self.textPhone.text = self.cellphone;
    }
}

- (IBAction)buttonLogin:(id)sender {
    NSString *phone = self.textPhone.text;
    NSString *password = self.textPassword.text;
    
    // 判断手机号
    if([self checkValideWithName:phone error:@"please_input_cellphone"]) return;
    
    // 判断密码
    if([self checkValideWithName:password error:@"please_input_password"]) return;
    
    // 隐藏键盘
    [self.view endEditing:YES];
    
    IWUserLoginParam *param = [[IWUserLoginParam alloc] init];
    param.loginName = phone;
    param.pwd = password;
    param.channel = @"IOS-V1.0.0";
    param.deviceToken = [IWUserTool accessToken];
    [MBProgressHUD showMessage:NSLocalizedString(@"login_loading", nil)];
    [IWUserTool userLoginWithParam:param success:^(IWUserLoginResult *result) {
        if (result.code == 0) {
            // 请求成功
            [IWToast toastWithView:self.view title:NSLocalizedString(@"login_success", nil)];
            
            // 存储模型数据
            IWUser *user = result.datas;
            user.pwd = param.pwd;
            user.password = password;
            [IWUserTool saveUser:user];
            
            // 跳转到首页
            self.view.window.rootViewController = [[IWTabBarViewController alloc] init];
        } else {
            // 请求失败
            [IWToast toastWithView:self.view title:result.info];
        }
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        // 隐藏加载框
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.textPassword) {
        [self buttonLogin:nil];
    }
    return YES;
}

- (IBAction)buttonRegister:(id)sender {
    IWUserRegisterViewController *userRegister = [[IWUserRegisterViewController alloc] init];
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:userRegister];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)buttonForget:(id)sender {
    IWForgetViewController *forget = [[IWForgetViewController alloc] init];
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:forget];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
