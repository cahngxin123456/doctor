//
//  IWTranningSystemViewController.m
//  Conedot
//
//  Created by 范超 on 15/1/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTranningSystemViewController.h"
#import "MJRefresh.h"
#import "IWNews.h"
#import "IWNavigationController.h"
#import "IWCompanyDetailViewController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWNewsViewCell.h"
#import "IWTrainningTool.h"
#import "IWToast.h"

@interface IWTranningSystemViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWTrainningResult *result;
@property (nonatomic, assign) int currentPageNumber;

@property (nonatomic, assign) long companyId;

@end

@implementation IWTranningSystemViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
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
    if (self.manualType == IWTrainningBookTypeSystem) {
        self.title = NSLocalizedString(@"trainning_system", nil);
    } else if (self.manualType == IWTrainningBookTypeIntro) {
        self.title = NSLocalizedString(@"trainning_intro", nil);
    } else if (self.manualType == IWTrainningBookTypeTeacher) {
        self.title = NSLocalizedString(@"teacher_intro", nil);
    } else if (self.manualType == IWTrainningBookTypeSpecial) {
        self.title = NSLocalizedString(@"special_project", nil);
    } else if (self.manualType == IWTrainningBookTypeOption) {
        self.title = NSLocalizedString(@"common_question", nil);
    } else {
        self.title = NSLocalizedString(@"trainning_system", nil);
    }
    
    self.companyId = IWCompanyId;
}

/**
 *  设置tableView属性
 */
- (void)setupTableView {
    self.tableView.rowHeight = 80;
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
    
    IWTrainningParam *param = [[IWTrainningParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    param.manualType = IWTrainningBookTypeSystem;
    
    [IWTrainningTool trainningSystemWithParam:param success:^(IWTrainningResult *result) {
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
    IWTrainningParam *param = [[IWTrainningParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.companyId);
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(IWPAGESIZE);
    param.manualType = self.manualType;
    
    [IWTrainningTool trainningSystemWithParam:param success:^(IWTrainningResult *result) {
        if (result.code == 0) {
            self.result = result;
            NSMutableArray *tempArray = [NSMutableArray array];
            [tempArray addObjectsFromArray:result.pageData];
            self.datas = tempArray;
            
            // 刷新表格
            [self.tableView reloadData];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
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
    IWNewsViewCell *cell = [IWNewsViewCell cellWithTableView:tableView];
    
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
    vc.trainningSystemId = news.ID;
    vc.fanCompany = self.company;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    // 刷新
    [self.tableView reloadData];
}

@end
