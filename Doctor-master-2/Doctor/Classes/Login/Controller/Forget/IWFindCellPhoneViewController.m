//
//  IWFindCellPhoneViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFindCellPhoneViewController.h"
#import "NSString+IW.h"
#import "IWToast.h"
#import "IWUserTool.h"
#import "MBProgressHUD+MJ.h"

@interface IWFindCellPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cellphone;
@property (weak, nonatomic) IBOutlet UITextField *cellphoneSc;
@property (weak, nonatomic) IBOutlet UITextField *newpassword;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UIButton *buttonSc;

- (IBAction)getRegisterSc;
@end

@implementation IWFindCellPhoneViewController

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
    [self.cellphone resignFirstResponder];
    [self.cellphoneSc resignFirstResponder];
    [self.newpassword resignFirstResponder];
    [self.passwordConfirm resignFirstResponder];
}

/**
 *  设置导航
 */
- (void)setupNavBar {
    self.title = NSLocalizedString(@"find_password_cellphone", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"find_password_ok", nil) style:UIBarButtonItemStyleDone target:self action:@selector(buttonConfirm)];
}

/**
 *  确认找回
 */
- (void)buttonConfirm {
    NSString *cellphone = self.cellphone.text;
    NSString *cellphoneSc = self.cellphoneSc.text;
    NSString *newPassword = self.newpassword.text;
    NSString *newPasswordConfirm = self.passwordConfirm.text;
    
    // 判断手机号
    if([self checkValideWithName:cellphone error:@"please_input_cellphone"]) return;
    if (![NSString validateMobile:cellphone]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_cellphone_error", nil)];
        return;
    }
    
    // 判断验证码
    if([self checkValideWithName:cellphoneSc error:@"please_input_cellphonesc"]) return;
    
    // 判断密码
    if([self checkValideWithName:newPassword error:@"please_input_password"]) return;
    if (![newPassword isEqualToString:newPasswordConfirm]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"confirm_password_error", nil)];
        return;
    }
    
    // 执行确认
    IWFindPasswordCellphoneParam *param = [[IWFindPasswordCellphoneParam alloc] init];
    param.cellphone = cellphone;
    param.pwdNew = newPasswordConfirm;
    param.securityCode = cellphoneSc;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"find_password_loading", nil)];
    [IWUserTool userFindPasswordCellphoneWithParam:param success:^(IWFindPasswordResult *result) {
        if (result.code == 0) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:NSLocalizedString(@"find_password_success", nil)];
            // 跳转到首页
            [self dismissViewControllerAnimated:YES completion:nil];
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
 *  计时
 */
-(void)startTime:(UIButton *)button {
    __block int timeout = IWTIMECOUNT; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:NSLocalizedString(@"get_code", nil) forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [button setTitle:[NSString stringWithFormat:@"%@%@",strTime, NSLocalizedString(@"second_send", nil)] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
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

/**
 *  获取验证码
 */
- (IBAction)getRegisterSc {
    // 判断手机号
    if([self checkValideWithName:self.cellphone.text error:@"please_input_cellphone"]) return;
    
    IWRegisterScParam *param = [[IWRegisterScParam alloc] init];
    param.cellphone = self.cellphone.text;
    
    UIButton *button = self.buttonSc;
    
    [IWUserTool userPasswordScWithParam:param success:^(IWRegisterScResult *result) {
        if (result.code != 0) {
            [MBProgressHUD showSuccess:result.info];
        } else {
            [MBProgressHUD showSuccess:NSLocalizedString(@"please_check_code", nil)];
            [self startTime:button];
        }
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
    }];
}
@end
