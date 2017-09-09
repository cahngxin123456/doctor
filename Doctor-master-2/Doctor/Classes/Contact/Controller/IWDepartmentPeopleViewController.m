//
//  IWDepartmentPeopleViewController.m
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWDepartmentPeopleViewController.h"
#import "IWContactGroup.h"
#import "IWContactHeaderView.h"
#import "IWDepartmentCell.h"
#import "IWPeopleCell.h"
#import "IWDepartment.h"
#import "IWPeople.h"
#import "IWContactTool.h"
#import "IWDepartmentViewController.H"
#import "IWPeopleViewController.h"
#import "IWToast.h"
#import "MBProgressHUD+MJ.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWFanCompany.h"
#import "IWPeople.h"
#import "IWContactAlertView.h"
#import "IWUserInfoViewController.h"
#import "IWNavigationController.h"
#import "IWBaseApprovalViewController.h"

@interface IWDepartmentPeopleViewController () <IWContactAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) IWPeople *people;
@end

@implementation IWDepartmentPeopleViewController

- (NSMutableArray *)datas {
    if (_datas == nil) {
        _datas = [NSMutableArray array];
        IWContactGroup *group0 = [[IWContactGroup alloc] init];
        group0.header = NSLocalizedString(@"department", nil);
        group0.items = self.departments;
        [_datas addObject:group0];
        
        IWContactGroup *group1 = [[IWContactGroup alloc] init];
        group1.header = NSLocalizedString(@"people", nil);
        group1.items = self.peoples;
        [_datas addObject:group1];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化view
    [self setupView];
    
    // 设置右边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
}

- (void)search {
//    IWContactSearchViewController *vc = [[IWContactSearchViewController alloc] init];
//    vc.isApproval = self.isApproval;
//    vc.company = self.company;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupView {
    self.view.backgroundColor = IWTableViewBgColor;
    
    // 设置tableview
    self.tableView.rowHeight = 50;
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置标题
    self.navigationItem.title = self.topTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    IWContactHeaderView *header = [IWContactHeaderView headerViewWithTableView:tableView];
    header.group = self.datas[section];
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    IWContactGroup *group = self.datas[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IWContactGroup *group = self.datas[indexPath.section];
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        // 显示组织
        IWDepartmentCell *departmentCell = [IWDepartmentCell cellWithTableView:tableView];
        departmentCell.department = group.items[indexPath.row];
        cell = departmentCell;
    } else {
        // 显示人员
        IWPeopleCell *peopleCell = [IWPeopleCell cellWithTableView:tableView];
        peopleCell.people = group.items[indexPath.row];
        cell = peopleCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 判断获取到的数据,进入相应的页面
    IWContactGroup *group = self.datas[indexPath.section];
    if (indexPath.section == 0) {
        // 进入部门
        IWDepartment *department = group.items[indexPath.row];
        [self loadDepartmentData:department];
    } else {
        // 显示人员dialog
        IWPeople *people = group.items[indexPath.row];
        if (self.isApproval) {
            // 返回approval页面
            [[NSUserDefaults standardUserDefaults] setValue:people.userId forKey:UserDefaultContactApprovalUserId];
            [[NSUserDefaults standardUserDefaults] setValue:people.userName forKey:UserDefaultContactApprovalUserName];
            
            BOOL isReturn = NO;
//            for (UIViewController *temp in self.navigationController.viewControllers) {
//                if ([temp isKindOfClass:[IWApprovalSenPiSubmitViewController class]] || [temp isKindOfClass:[IWBaseApprovalViewController class]]) {
//                    [self.navigationController popToViewController:temp animated:YES];
//                    isReturn = YES;
//                }
//            }
            if (!isReturn) {
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
            }
            
        } else {
            [self showPeopleDialog:people];
        }
    }
}

/**
 *  显示dialog
 */
- (void)showPeopleDialog:(IWPeople *)people {
    // 只有人员
    IWGetHosptialParam *param = [[IWGetHosptialParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.hospitalId = people.hospitalId;
    
    // 显示加载框
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWContactTool getHospitalList:param success:^(IWGetHospitalContactResult *result) {
        IWLog(@"%@",result.contactDatas);
            // 只有人员
        IWPeopleViewController *peopleVc = [[IWPeopleViewController alloc] init];
        peopleVc.isApproval = self.isApproval;
        peopleVc.datas = result.contactDatas;
        peopleVc.topTitle = people.hospitalName;
        peopleVc.nTitle = people.hospitalName;
        [self.navigationController pushViewController:peopleVc animated:YES];
        
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
        // 隐藏加载框
        [MBProgressHUD hideHUD];
    }];
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
            dpVc.isApproval = self.isApproval;
            dpVc.departments = result.communityDatas;
            dpVc.peoples = result.hospitalDatas;
            dpVc.topTitle = department.deptName;
            dpVc.nTitle = department.deptRemarkName;
            [self.navigationController pushViewController:dpVc animated:YES];
        } else if (result.communityDatas != nil && result.communityDatas.count > 0) {
            // 只有部门
            // 进入下一级页面
            IWDepartmentViewController *vc = [[IWDepartmentViewController alloc] init];
            vc.isApproval = self.isApproval;
            vc.topTitle = department.deptName;
            vc.datas = result.communityDatas;
            vc.nTitle = department.deptRemarkName;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            // 只有人员
            IWPeopleViewController *peopleVc = [[IWPeopleViewController alloc] init];
            peopleVc.isApproval = self.isApproval;
            peopleVc.datas = result.hospitalDatas;
            peopleVc.topTitle = department.deptName;
            peopleVc.nTitle = department.deptRemarkName;
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
