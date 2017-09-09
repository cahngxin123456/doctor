//
//  IWMeViewController.m
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWMeViewController.h"
#import "IWMeHeaderView.h"
#import "IWSettingGroup.h"
#import "IWSettingArrowItem.h"
#import "IWSettingLabelItem.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWBirthdayViewController.h"
#import "IWEmailViewController.h"
#import "IWCellPhoneViewController.h"
#import "IWPasswordViewController.h"
#import "IWContactSettingViewController.h"
#import "IWRelativeSettingViewController.h"
#import "IWNotificationViewController.h"
#import "IWUserLoginViewController.h"
#import "IWAboutViewController.h"
#import "IWAddressViewController.h"
#import "MBProgressHUD+MJ.h"
#import "IWMeTool.h"
#import "IWCompanyTool.h"
#import "IWHelpViewController.h"
#import "PAImageView.h"
#import "IWToast.h"
#import "IWProfileInfoViewController.h"


@interface IWMeViewController () <IWMeHeaderViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) IWSettingLabelItem *birthday;
@property (nonatomic, weak) IWSettingLabelItem *address;
@property (nonatomic, weak) IWSettingLabelItem *email;
@property (nonatomic, weak) IWSettingLabelItem *cellphone;

@property (nonatomic, weak) IWMeHeaderView *headerView;
@property (nonatomic, weak) UIActionSheet *iconSheet;
@property (nonatomic, weak) PAImageView *paImageView;
@end

@implementation IWMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView属性
    [self setupTableView];
    
    [self setupGroup1];
    [self setupGroup2];
    [self setupFooter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
        
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    IWUser *user = [IWUserTool user];
    self.headerView.user = user;
    self.birthday.defaultText = user.birthday;
    self.email.defaultText = user.mail;
    self.address.defaultText = user.birthplace2show;
    [self.tableView reloadData];
}

/**
 *  设置tableView属性
 */
- (void)setupTableView {
    IWMeHeaderView *headerView = [IWMeHeaderView headerView];
    headerView.delegate = self;
    headerView.user = [IWUserTool user];
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);;
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
}

- (void)viewClick {
    IWProfileInfoViewController *vc = [[IWProfileInfoViewController alloc] init];
    vc.isFromMine = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  设置
 */
- (void)setting {
    IWContactSettingViewController *vc = [[IWContactSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupGroup1 {
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *password = [IWSettingArrowItem itemWithIcon:@"password" title:NSLocalizedString(@"change_password", nil) destVcClass:[IWPasswordViewController class]];
    IWSettingArrowItem *message = [IWSettingArrowItem itemWithIcon:@"message" title:NSLocalizedString(@"message", nil) destVcClass:[IWNotificationViewController class]];
    
    
    group.items = @[password, message];
}

- (void)setupGroup2 {
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *about = [IWSettingArrowItem itemWithIcon:@"about" title:NSLocalizedString(@"about", nil) destVcClass:[IWAboutViewController class]];
    
    IWSettingArrowItem *help = [IWSettingArrowItem itemWithIcon:@"help" title:NSLocalizedString(@"help_feedback", nil) destVcClass:[IWHelpViewController class]];
    
    group.items = @[about, help];
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
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) destructiveButtonTitle:NSLocalizedString(@"log_out", nil) otherButtonTitles:nil, nil];
    
    for (UIButton *button in sheet.subviews) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == self.iconSheet) {
        switch (buttonIndex) {
            case 0:
                // 拍照
                [self openCamera];
                break;
            case 1:
                // 图库
                [self openAlbum];
                break;
        }
    } else {
        switch (buttonIndex) {
            case 0: // 退出登录
            [self logoutButton];
            break;
            default:
            break;
        }
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    IWLog(@"%@", info);
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.paImageView setImage:image];
    
    // 保存头像到服务器
    [self savePhotoServer];
}

- (void)savePhotoServer {
    IWMeParam *param = [[IWMeParam alloc] init];
    param.cellphone = [IWUserTool user].cellphone;
    param.pwd = [IWUserTool user].pwd;
    NSData *headData = UIImageJPEGRepresentation(self.paImageView.image, 0.5);
    [IWMeTool updateIconWithParams:param data:headData success:^(IWBaseResult *result) {
        if (result.code == 0) {
            [IWToast toastWithView:self.view title:NSLocalizedString(@"change_picture_success", nil)];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"change_picture_fail", nil)];
    }];
}

- (void)logoutButton {
    // 移除用户
    [IWUserTool removeUser];
    [IWCompanyTool removeFancompany];
    // 移除图标右上角的数字
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // 退到登录页面
    IWUserLoginViewController *loginVc = [[IWUserLoginViewController alloc] init];
    [self presentViewController:loginVc animated:YES completion:nil];
}

@end
