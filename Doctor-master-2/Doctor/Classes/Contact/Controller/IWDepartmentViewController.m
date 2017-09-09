//
//  IWDepartmentViewController.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWDepartmentViewController.h"
#import "IWContactTool.h"
#import "IWFanCompany.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWToast.h"
#import "MBProgressHUD+MJ.h"
#import "IWDepartmentCell.h"
#import "IWCommonContactCell.h"
#import "IWDepartment.h"
#import "IWDepartmentPeopleViewController.h"
#import "IWPeopleViewController.h"
#import "IWContactHeaderView.h"
#import "IWContactGroup.h"
#import "IWCommonContact.h"

@interface IWDepartmentViewController ()

@property (nonatomic, strong) NSMutableArray *groupDatas;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation IWDepartmentViewController

- (NSMutableArray *)groupDatas {
    if (_groupDatas == nil) {
        _groupDatas = [NSMutableArray array];
        IWContactGroup *group0 = [[IWContactGroup alloc] init];
        group0.header = NSLocalizedString(@"community_title", nil);
        group0.items = self.datas;
        [_groupDatas addObject:group0];
    }
    return _groupDatas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 初始化view
    [self setupView];
    
    // 设置右边的item
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    
    // 加载
    if (self.datas == nil) {
        [self loadDepartmentData];
    }
    
    // 设置常用联系人
    [self loadCommonContact];
}

- (void)loadDepartmentData {
    IWGetCommunityParam *param = [[IWGetCommunityParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.type = @"contact";
    
    [IWContactTool getCommunityList:param success:^(IWGetCommunityResult *result) {
        // 存储用于显示title
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:UserDefaultContactHeaderTitle];
        [[NSUserDefaults standardUserDefaults] setValue:NSLocalizedString(@"community_title", nil) forKey:UserDefaultContactHeaderTitle];
        
        if (result.communityDatas != nil && result.communityDatas.count > 0) {
            self.datas = result.communityDatas;
            
            NSMutableArray *groupDatas = [NSMutableArray array];
            IWContactGroup *group0 = [[IWContactGroup alloc] init];
            group0.header = NSLocalizedString(@"community_title", nil);
            group0.items = result.communityDatas;
            [groupDatas addObject:group0];
            self.groupDatas = groupDatas;
            [self.tableView reloadData];
        }

    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)loadCommonContact {
    IWContactParam *param = [[IWContactParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    [IWContactTool commonContactWithParam:param success:^(IWCommonContactResult *result) {
        if (result.contactDatas != nil && result.contactDatas.count > 0) {
            // 刷新数据
            IWContactGroup *group0 = [[IWContactGroup alloc] init];
            group0.header = NSLocalizedString(@"common_contact", nil);
            group0.items = result.contactDatas;
            [self.groupDatas insertObject:group0 atIndex:0];
            
            [self.tableView reloadData];
            
        }
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)search {
//    IWContactSearchViewController *vc = [[IWContactSearchViewController alloc] init];
//    vc.isApproval = self.isApproval;
//    vc.company = self.company;
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    // 设置tableview
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置title
    if (self.topTitle != nil) {
        self.navigationItem.title = self.topTitle;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.topTitle == nil) {
        return 0;
    } else {
        return 26;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupDatas.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    IWContactHeaderView *header = [IWContactHeaderView headerViewWithTableView:tableView];
    header.group = self.groupDatas[section];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IWContactGroup *group = self.groupDatas[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IWContactGroup *group = self.groupDatas[indexPath.section];
    UITableViewCell *cell = nil;
    if (self.groupDatas.count == 1) {
        // 显示组织
        IWDepartmentCell *departmentCell = [IWDepartmentCell cellWithTableView:tableView];
        departmentCell.department = group.items[indexPath.row];
        cell = departmentCell;
    } else {
        if (indexPath.section == 0) {
            // 显示人员
            IWCommonContactCell *peopleCell = [IWCommonContactCell cellWithTableView:tableView];
            peopleCell.contact = group.items[indexPath.row];
            cell = peopleCell;
        } else {
            // 显示组织
            IWDepartmentCell *departmentCell = [IWDepartmentCell cellWithTableView:tableView];
            departmentCell.department = group.items[indexPath.row];
            cell = departmentCell;
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IWContactGroup *group = self.groupDatas[indexPath.section];
    if (self.groupDatas.count == 1) {
        // 判断获取到的数据,进入相应的页面
        IWDepartment *department = group.items[indexPath.row];
        [self loadDepartmentData:department];
    } else {
        if (indexPath.section == 0) {
            // 显示打电话的按钮
            IWCommonContact *common = group.items[indexPath.row];
            [self dialPhone:common.number];
        } else {
            // 判断获取到的数据,进入相应的页面
            IWDepartment *department = group.items[indexPath.row];
            [self loadDepartmentData:department];
        }
    }
    
}

// 拨打电话
- (void)dialPhone:(NSString *)phone {
    // 拨打电话
    NSString *real_phone = [NSString stringWithFormat:@"tel://%@", phone];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:real_phone]]];
}


/**
 *  加载部门数据
 */
- (void)loadDepartmentData:(IWDepartment *)department {
    IWGetCommunityParam *param = [[IWGetCommunityParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.type = @"contact";
    param.communityId = department.deptId;
    
    // 显示加载框
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWContactTool getCommunityList:param success:^(IWGetCommunityResult *result) {
        IWLog(@"%@",department.deptRemarkName);
        
        // 判断
        if (result.communityDatas != nil && result.communityDatas.count > 0 && result.hospitalDatas != nil && result.hospitalDatas.count > 0) {
            // 有部门，有人员
            IWDepartmentPeopleViewController *dpVc = [[IWDepartmentPeopleViewController alloc] init];
            dpVc.departments = result.communityDatas;
            dpVc.peoples = result.hospitalDatas;
            dpVc.topTitle = department.deptName;
            dpVc.nTitle = department.deptRemarkName;
            [self.navigationController pushViewController:dpVc animated:YES];
        } else if (result.communityDatas != nil && result.communityDatas.count > 0) {
            // 只有部门
            // 进入下一级页面
            IWDepartmentViewController *vc = [[IWDepartmentViewController alloc] init];
            vc.topTitle = department.deptName;
            vc.nTitle = department.deptRemarkName;
            vc.datas = result.communityDatas;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            // 只有人员
            IWPeopleViewController *peopleVc = [[IWPeopleViewController alloc] init];
//            peopleVc.isApproval = self.isApproval;
//            peopleVc.datas = result.userDatas;
//            peopleVc.topTitle = department.deptName;
//            peopleVc.nTitle = department.deptRemarkName;
            [self.navigationController pushViewController:peopleVc animated:YES];
        }
        
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    }];
}
@end
