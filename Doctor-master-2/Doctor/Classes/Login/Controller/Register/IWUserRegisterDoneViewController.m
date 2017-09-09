//
//  IWUserRegisterDoneViewController.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWUserRegisterDoneViewController.h"
#import "IWToast.h"
#import "IWTabBarViewController.h"

@interface IWUserRegisterDoneViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *retryPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;
- (IBAction)registerDone:(UIButton *)sender;
@end

@implementation IWUserRegisterDoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"register_set_password", nil);
    
    // 按钮
    [self.buttonRegister setBackgroundImage:[UIImage resizedImageWithName:@"btn_green"] forState:UIControlStateNormal];
    [self.buttonRegister setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_highlighted"] forState:UIControlStateHighlighted];
    [self.buttonRegister setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_disabled"] forState:UIControlStateDisabled];
    
    [self.password setDelegate:self];
    [self.retryPassword setDelegate:self];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resignAllFirstResponder];
}

- (void)resignAllFirstResponder {
    [self.password resignFirstResponder];
    [self.retryPassword resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.password) {
        [self.retryPassword becomeFirstResponder];
    } else if (textField == self.retryPassword) {
        [self userRegister];
    }
    return YES;
}

/**
 *  提交注册
 */
- (void)userRegister {
    NSString *password = self.password.text;
    NSString *retryPassword = self.retryPassword.text;
    
    // 判断密码
    if([self checkValideWithName:password error:@"please_input_password"]) return;
    
    if (![retryPassword isEqualToString:password]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"retry_password_error", nil)];
        return;
    }    
    
    // 隐藏键盘
    [self.view endEditing:YES];
    
    // 执行注册
    IWRegisterParam *param = [[IWRegisterParam alloc] init];
    param.cellphone = self.phone;
    param.pwd = password;
    param.channel = param.channel;
    param.deviceToken = [IWUserTool accessToken];
    
    [MBProgressHUD showMessage:NSLocalizedString(@"register_loading", nil)];
    [IWUserTool userRegisterWithParam:param success:^(IWRegisterResult *result) {
        if (result.code == 0) {
            // 请求成功
            [IWToast toastWithView:self.view title:NSLocalizedString(@"register_success", nil)];
            
            // 存储模型数据
            IWUser *user = result.datas;
            user.pwd = param.pwd;
            user.password = password;
            [IWUserTool saveUser:result.datas];
            
            // 跳转到首页
            [self dismissViewControllerAnimated:YES completion:nil];
            self.view.window.rootViewController = [[IWTabBarViewController alloc] init];
        } else {
            // 请求失败
            [IWToast toastWithView:self.view title:result.info];
        }
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
    
}

- (IBAction)registerDone:(UIButton *)sender {
    [self userRegister];
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
