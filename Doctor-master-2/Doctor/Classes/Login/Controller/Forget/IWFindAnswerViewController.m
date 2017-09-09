//
//  IWFindAnswerViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFindAnswerViewController.h"
#import "NSString+IW.h"
#import "IWToast.h"
#import "IWUserTool.h"
#import "MBProgressHUD+MJ.h"

@interface IWFindAnswerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation IWFindAnswerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航
    [self setupNavBar];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resignAllFirstResponder];
}

- (void)resignAllFirstResponder {
    [self.username resignFirstResponder];
}

/**
 *  设置导航
 */
- (void)setupNavBar {
    self.title = NSLocalizedString(@"find_password_answer", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"find_password_next", nil) style:UIBarButtonItemStyleDone target:self action:@selector(next)];
}

/**
 *  下一步
 */
- (void)next {
    NSString *userName = self.username.text;
    // 判断用户名
    if ([self checkValideWithName:userName error:@"please_input_username"]) return;
    
    // 下一步
    
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
