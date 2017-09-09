//
//  IWMyDoctorViewController.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWMyDoctorViewController.h"
#import "IWNnpTool.h"
#import "MJRefresh.h"
#import "IWNews.h"
#import "IWNavigationController.h"
#import "IWMyDoctorTool.h"
#import "IWUser.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "IWMyDoctorViewCell.h"
#import "IWWebViewController.h"
#import "IWMyDoctor.h"
#import "IWShareWebViewController.h"

@interface IWMyDoctorViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@end

@implementation IWMyDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
    [self setupTableView];
    
    // 集成刷新控件
    [self setupRefreshView];
}

/**
 *  设置tableView属性
 */
- (void)setupTableView {
    self.title = NSLocalizedString(@"my_doctor_title", nil);
    self.tableView.rowHeight = 90;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView {
    // 1. 下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
}

- (void)dealloc {
    // 释放内存
    [self.header free];
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) { // 下拉刷新
        [self loadNewData];
    }
}

/**
 *  加载数据
 */
- (void)loadNewData {
    IWMyDoctorParam *param = [[IWMyDoctorParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    
    [IWMyDoctorTool myDoctorWithParam:param success:^(IWMyDoctorResult *result) {
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:result.datas];
        self.datas = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    IWMyDoctorViewCell *cell = [IWMyDoctorViewCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.myDoctor = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IWMyDoctor *myDoctor = self.datas[indexPath.row];
    
    if (self.isFromInquiry) {
        if (_fromeControllerBlock) {
            _fromeControllerBlock(myDoctor.ID,myDoctor.name);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        // 进入详情页面
        NSString *url = [NSString stringWithFormat:SERVER_GET_VIEW_SPECIAL_DOCTORINFO_URL, myDoctor.ID, [IWUserTool user].loginId];
        
        IWWebViewController *vc = [[IWWebViewController alloc] init];
        vc.navTitle = NSLocalizedString(@"doctor_sign_doctorinfo", nil);
        vc.url = url;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

@end
