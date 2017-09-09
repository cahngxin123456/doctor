//
//  IWCellPhoneViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWCellPhoneViewController.h"
#import "IWToast.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWMeTool.h"
#import "IWUserLoginViewController.h"
#import "MBProgressHUD+MJ.h"

@interface IWCellPhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cellphone;
@property (weak, nonatomic) IBOutlet UITextField *cellphoneVc;

@property (weak, nonatomic) IBOutlet UIButton *buttonVc;

- (IBAction)getVc:(id)sender;
@end

@implementation IWCellPhoneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"finish", nil) style:UIBarButtonItemStyleDone target:self action:@selector(finish)];
}

- (void)finish {
    NSString *newCellPhone = self.cellphone.text;
    NSString *cellPhoneVc = self.cellphoneVc.text;
    
    if ([newCellPhone isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_cellphone", nil)];
        return;
    }
    
    if ([cellPhoneVc isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_cellphonesc", nil)];
        return;
    }
    
    IWChangeCellPhoneParam *param = [[IWChangeCellPhoneParam alloc] init];
    param.loginName = [IWUserTool user].loginName;
    param.pwd = [IWUserTool user].pwd;
    param.cellphoneNew = newCellPhone;
    param.securityCode = cellPhoneVc;
    
    [IWMeTool changeCellPhoneWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 保存信息
            IWUser *user = [IWUserTool user];
            user.cellphone = param.cellphoneNew;
            [IWUserTool saveUser:user];
            
            // 关闭控制器
//            [self.navigationController popViewControllerAnimated:YES];
            [self logoutButton:user.cellphone];
        }
        [MBProgressHUD showSuccess:NSLocalizedString(@"change_success", nil)];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:NSLocalizedString(@"change_fail", nil)];
    }];
}

- (void)logoutButton:(NSString *)cellphone {
    [IWUserTool removeUser];
    IWUserLoginViewController *loginVc = [[IWUserLoginViewController alloc] init];
    loginVc.cellphone = cellphone;
    [UIApplication sharedApplication].keyWindow.rootViewController = loginVc;
}

- (IBAction)getVc:(id)sender {
    NSString *newCellPhone = self.cellphone.text;
    // 判断手机号
    if ([newCellPhone isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_cellphone", nil)];
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    
    IWResetCellphoneParam *param = [[IWResetCellphoneParam alloc] init];
    param.loginName = [IWUserTool user].loginName;
    param.pwd = [IWUserTool user].pwd;
    param.cellphoneNew = newCellPhone;
    [IWUserTool userChangePhoneScWithParam:param success:^(IWRegisterScResult *result) {
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
@end
