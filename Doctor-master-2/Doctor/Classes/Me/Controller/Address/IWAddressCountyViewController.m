//
//  IWAddressCountyViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAddressCountyViewController.h"
#import "IWAddressTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "IWMeTool.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWTabBarViewController.h"

@interface IWAddressCountyViewController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation IWAddressCountyViewController

- (void)viewDidLoad {
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
    self.title = self.address.regionName;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.rowHeight = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    self.city = self.address.regionName;
}

/**
 *  加载数据
 */
- (void)loadData {
    IWAddressParam *param = [[IWAddressParam alloc] init];
    param.listType = @"county";
    param.parentCode = self.address.regionCode;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWAddressTool addressWithParam:param success:^(IWAddressResult *result) {
        if (result.code == 0) {
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:result.datas];
            self.datas = tempArray;
            
            // 刷新表格
            [self.tableView reloadData];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"address";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    IWAddress *address = self.datas[indexPath.row];
    
    cell.textLabel.text = address.regionName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 进入详情页面
    IWAddress *address = self.datas[indexPath.row];
    
    // 修改区域
    IWMeParam *param = [[IWMeParam alloc] init];
    param.cellphone = [IWUserTool user].cellphone;
    param.pwd = [IWUserTool user].pwd;
    param.birthplace = address.regionCode;
    [MBProgressHUD showMessage:NSLocalizedString(@"change_userinfo_loading", nil)];
    [IWMeTool changeUserInfoWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 保存信息
            IWUser *user = [IWUserTool user];
            user.birthplace = address.regionName;
            user.birthplace2show = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, address.regionName];
            user.cpf = address.cpfAddress;
            user.socialSecurity = address.socialSecurity;
            [IWUserTool saveUser:user];
            
            [IWToast toastWithView:self.view title:result.info];
            
            // 退到首页
            if (self.isSocial) {
                [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex: ([self.navigationController.viewControllers count] -4)] animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
@end
