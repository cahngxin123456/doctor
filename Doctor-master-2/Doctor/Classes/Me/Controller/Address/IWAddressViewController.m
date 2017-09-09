//
//  IWAddressViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAddressViewController.h"
#import "IWAddressTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "IWAddressCityViewController.h"

@interface IWAddressViewController ()
@property (nonatomic, strong) NSArray *datas;
@end

@implementation IWAddressViewController

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
    self.title = NSLocalizedString(@"choose_city", nil);
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.rowHeight = 44;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

/**
 *  加载数据
 */
- (void)loadData {
    IWAddressParam *param = [[IWAddressParam alloc] init];
    param.listType = @"province";
    
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 进入详情页面
    IWAddress *address = self.datas[indexPath.row];
    
    IWAddressCityViewController *vc = [[IWAddressCityViewController alloc] init];
    vc.address = address;
    vc.isSocial = self.isSocial;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
