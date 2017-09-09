//
//  IWNppViewController.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWNppViewController.h"
#import "IWNnpTool.h"
#import "MJRefresh.h"
#import "IWNews.h"
#import "IWNavigationController.h"
#import "IWCompanyDetailViewController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWNnpViewCell.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"

@interface IWNppViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWNppResult *result;
@property (nonatomic, assign) int currentPageNumber;
@end

@implementation IWNppViewController

- (void)viewDidLoad
{
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
    self.title = NSLocalizedString(@"doctor_notice", nil);
    self.tableView.rowHeight = 80;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
//    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
//    self.navigationItem.rightBarButtonItems = @[search];
}


/**
 *  搜索
 */
- (void)search:(UIBarButtonItem *)item {
//    IWSearchViewController *searchVC = [[IWSearchViewController alloc] init];
//    searchVC.type = IWSearchControllerTypeNews;
//    searchVC.company = self.company;
//    [self.navigationController pushViewController:searchVC animated:YES];
}

- (UIButton *)setupButtonWithText:(NSString *)text {
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    return button;
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
    
    // 2. 上拉刷新(上拉加载更多数据)
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}

- (void)dealloc {
    // 释放内存
    [self.header free];
    [self.footer free];
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
        self.currentPageNumber++;
        [self loadMoreData];
    } else { // 下拉刷新
        self.currentPageNumber = 1;
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的微博数据
 */
- (void)loadMoreData {
    // 计算当前的页码
    double number = (double)self.result.totalCount / IWPAGESIZE;
    IWLog(@"%f", number);
    if (self.currentPageNumber > (int)ceil(number)) {
        [self.footer endRefreshing];
        return;
    }
    
    IWNppParam *param = [[IWNppParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.company.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    
    [IWNnpTool nnpWithParam:param success:^(IWNppResult *result) {
        // 设置数据
        [self.datas addObjectsFromArray:result.pageData];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        // 让刷新控件停止显示刷新状态
        [self.footer endRefreshing];
    }];
}

/**
 *  加载数据
 */
- (void)loadNewData {
    IWNppParam *param = [[IWNppParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.company.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    
    [IWNnpTool nnpWithParam:param success:^(IWNppResult *result) {
        self.result = result;
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:result.pageData];
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
    IWNnpViewCell *cell = [IWNnpViewCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.news = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 进入详情页面
    IWNews *news = self.datas[indexPath.row];
    news.readStatus = 1;
    
    IWCompanyDetailViewController *vc = [[IWCompanyDetailViewController alloc] init];
    if ([news.category isEqualToString:@"notice"]) {
        vc.noticeId = news.ID;
    } else if ([news.category isEqualToString:@"policy"]) {
        vc.policyId = news.ID;
    } else {
        vc.newsId = news.ID;
    }
    vc.fanCompany = self.company;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView reloadData];
}


@end
