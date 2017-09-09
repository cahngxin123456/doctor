//
//  IWTrainningCourseViewController.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWTrainningCourseViewController.h"
#import "MJRefresh.h"
#import "IWNews.h"
#import "IWNavigationController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWTrainingCourseAcceptCell.h"
#import "IWTrainingCourseCell.h"
#import "IWTrainningWebViewController.h"
#import "IWTrainningTool.h"
#import "IWToast.h"
#import "IWCourse.h"

@interface IWTrainningCourseViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWTrainningCourseResult *result;
@property (nonatomic, assign) int currentPageNumber;

@property (nonatomic, assign) long companyId;
@end

@implementation IWTrainningCourseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    self.companyId = IWCompanyId;
    // 设置基本
    [self setupBase];
    
    // 设置tableView属性
    [self setupTableView];
    
    // 集成刷新控件
    [self setupRefreshView];
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.companyId = IWCompanyId;
}

/**
 *  设置tableView属性
 */
- (void)setupTableView {
    if (self.listType == IWTrainningCourseTypeAll) {
        self.tableView.rowHeight = 220;
    } else {
        self.tableView.rowHeight = 200;
    }
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
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
    
    IWTrainningCourseParam *param = [[IWTrainningCourseParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.company.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    param.listType = self.listType;
    
    [IWTrainningTool trainningManagerCourseWithParam:param success:^(IWTrainningCourseResult *result) {
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
    IWTrainningCourseParam *param = [[IWTrainningCourseParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    param.listType = self.listType;
    
    [IWTrainningTool trainningManagerCourseWithParam:param success:^(IWTrainningCourseResult *result) {
        if (result.code == 0) {
            self.result = result;
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:result.pageData];
            self.datas = tempArray;
            
            // 刷新表格
            [self.tableView reloadData];
        } else {
            [IWToast toastWithView:self.view title:result.info];
            [self.datas removeAllObjects];
            [self.tableView reloadData];
        }
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        [self.tableView reloadData];
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    if (self.listType == IWTrainningCourseTypeAll) {
        IWTrainingCourseAcceptCell *cell = [IWTrainingCourseAcceptCell cellWithTableView:tableView];
        cell.vc = self;
        // 2.传递frame模型
        cell.course = self.datas[indexPath.row];
        return cell;
    } else {
        IWTrainingCourseCell *cell = [IWTrainingCourseCell cellWithTableView:tableView];
        // 2.传递frame模型
        cell.course = self.datas[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 进入详情页面
    IWCourse *course = self.datas[indexPath.row];

    NSString *url = [NSString stringWithFormat:SERVER_GET_TRAINNING_COURSE_DETAIL_URL, course.ID, [NSString stringWithFormat:@"%ld", self.companyId], [IWUserTool user].loginId];
    
    IWTrainningWebViewController *vc = [[IWTrainningWebViewController alloc] init];
    vc.navTitle = NSLocalizedString(@"trainning_course_detail_title", nil);
    vc.url = url;
    vc.classId = course.classInfoId;
    [self.nav pushViewController:vc animated:YES];
}

@end