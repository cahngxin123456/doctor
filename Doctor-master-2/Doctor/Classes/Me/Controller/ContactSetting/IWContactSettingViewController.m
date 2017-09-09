//
//  IWContactSettingViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWContactSettingViewController.h"
#import "IWSettingSwitchItem.h"
#import "IWSettingLabelItem.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWAboutViewController.h"
#import "IWUserLoginViewController.h"
#import "IWUser.h"
#import "IWUserTool.h"

@interface IWContactSettingViewController () <UIActionSheetDelegate>

@end

@implementation IWContactSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"setting", nil);
    
    [self setupGroup0];
    [self setupFooter];
}

- (void)setupGroup0 {
    IWSettingGroup *group = [self addGroup];
    
    IWSettingSwitchItem *pushMessage = [IWSettingSwitchItem itemWithTitle:NSLocalizedString(@"message_push", nil)];
    
    IWSettingLabelItem *cleanCache = [IWSettingLabelItem itemWithTitle:NSLocalizedString(@"clean_cache", nil)];
    
    IWSettingArrowItem *about = [IWSettingArrowItem itemWithTitle:NSLocalizedString(@"about", nil) destVcClass:[IWAboutViewController class]];
    
    group.items = @[pushMessage, cleanCache, about];
}

- (void)setupFooter {
    // 按钮
    UIButton *logoutButton = [[UIButton alloc] init];
    CGFloat logoutX = IWTableBorderW + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 40;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageWithName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:NSLocalizedString(@"logout", nil) forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = 40 + IWCellMargin;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}

- (void)logout {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"take_picture_cancel", nil) destructiveButtonTitle:NSLocalizedString(@"log_out", nil) otherButtonTitles:nil, nil];
    
    for (UIButton *button in sheet.subviews) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: // 退出登录
            [self logoutButton];
            break;
        default:
            break;
    }
}

- (void)logoutButton {
    [IWUserTool removeUser];
    IWUserLoginViewController *loginVc = [[IWUserLoginViewController alloc] init];
//    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:loginVc];
    [self presentViewController:loginVc animated:YES completion:nil];
}
@end
