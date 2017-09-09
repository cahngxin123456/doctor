//
//  IWPeopleViewController.m
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWPeopleViewController.h"
#import "IWHospitalContactCell.h"
#import "IWPeople.h"
#import "IWContactAlertView.h"
#import "IWUserInfoViewController.h"
#import "IWNavigationController.h"
#import "IWContactTool.h"
#import "IWBaseApprovalViewController.h"

@interface IWPeopleViewController () <IWContactAlertViewDelegate>
@property (nonatomic, strong) UILocalizedIndexedCollation *collation;
@property (nonatomic, strong) NSArray *sectionsArray;
@property (nonatomic, strong) IWPeople *people;

@end

@implementation IWPeopleViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置tableview
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置title
    self.navigationItem.title = self.topTitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    IWHospitalContactCell *cell = [IWHospitalContactCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.contact = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
