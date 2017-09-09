//
//  IWRelativeSettingViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWRelativeSettingViewController.h"
#import "IWCompanyTool.h"
#import "IWMeTool.h"
#import "IWFanCompany.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWFanCompanySettingViewCell.h"
#import "MBProgressHUD+MJ.h"

@interface IWRelativeSettingViewController () <IWFanCompanySettingViewCellDelegate>
@property (nonatomic, strong) NSArray *fans;
@end

@implementation IWRelativeSettingViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航
    [self setupNavBar];

    // 加载数据
    [self loadData];
}

/**
 *  设置导航
 */
- (void)setupNavBar {
    self.title = NSLocalizedString(@"choose_company", nil);
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.rowHeight = 70;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

/**
 *  加载数据
 */
- (void)loadData {
    IWCompanyFanParam *param = [[IWCompanyFanParam alloc] init];
    param.loginName = [IWUserTool user].loginName;
    param.pwd = [IWUserTool user].pwd;
    
    [IWCompanyTool companyFanWithParam:param success:^(IWCompanyFanResult *result) {
        self.fans = result.datas;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取cell
    IWFanCompanySettingViewCell *cell = [IWFanCompanySettingViewCell cellWithTableView:tableView];
    
    cell.delegate = self;
    
    // 设置数据
    cell.fan = self.fans[indexPath.row];
    
    return cell;
}

- (void)switchStatusWithFan:(IWFanCompany *)fan usingStatus:(int)usingStatus {
    IWStatusCompanyParam *param = [[IWStatusCompanyParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.fansId = @(fan.ID);
    param.usingStatus = usingStatus;
    
    [IWMeTool changeStatusCompanyWithParam:param success:^(IWBaseResult *result) {
        // 改变模型里的数据
        for (IWFanCompany *oldfan in self.fans) {
            if (oldfan.ID == fan.ID) {
                oldfan.usingStatus = usingStatus;
            }
        }
        
        // 判断本地是不是存储一样的，如果是一样的就移除
        IWFanCompany *fancompany = [IWCompanyTool fancompany];
        if (fancompany.ID == fan.ID && usingStatus == 0) {
            [IWCompanyTool removeFancompany];
            
            // 查看是否有其他的公司
            for (IWFanCompany *fanc in self.fans) {
                if (fanc.usingStatus == 1) {
                    [IWCompanyTool saveFanCompany:fanc];
                    break;
                }
            }
        }
        if (usingStatus == 1) {
            [IWCompanyTool saveFanCompany:fan];
        }
        
        // 提示
        [MBProgressHUD showSuccess:NSLocalizedString(@"change_success", nil)];
        
        // 发通知
        [IWNotificationCenter postNotificationName:@"fanChange" object:self];
        
    } failure:^(NSError *error) {
        [MBProgressHUD showError:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    IWCompanyMainViewController *companyMainVc = [[IWCompanyMainViewController alloc] init];
//    companyMainVc.fan = self.fans[indexPath.row];
//    [self.navigationController pushViewController:companyMainVc animated:YES];
}

@end
