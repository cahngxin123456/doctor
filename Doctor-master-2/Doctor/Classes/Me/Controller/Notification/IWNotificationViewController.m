//
//  IWNotificationViewController.m
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNotificationViewController.h"
#import "MJRefresh.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWMeTool.h"
#import "IWNotificationViewCell.h"
#import "IWToast.h"
#import "IWNotification.h"

@interface IWNotificationViewController ()<MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWNotificationResult *result;
@property (nonatomic, assign) int currentPageNumber;

@end

@implementation IWNotificationViewController

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
    self.title = NSLocalizedString(@"message", nil);
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
    double number = (double)self.result.totalCount / 20;
    IWLog(@"%f", number);
    if (self.currentPageNumber > (int)ceil(number)) {
        [self.footer endRefreshing];
        return;
    }
    
    IWNotificationParam *param = [[IWNotificationParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(20);
    
    [IWMeTool notificationWithParam:param success:^(IWNotificationResult *result) {
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
    IWNotificationParam *param = [[IWNotificationParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(20);
    
    [IWMeTool notificationWithParam:param success:^(IWNotificationResult *result) {
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
    if (self.datas.count) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    IWNotificationViewCell *cell = [IWNotificationViewCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.notification = self.datas[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 请求读取
    IWNotification *notification = self.datas[indexPath.row];
    
    if (notification.status == 0) {
        // 未读
        [self readNotification:indexPath.row];
    }
}

- (void)readNotification:(NSInteger)index {
    // 获取当前notification
    IWNotification *notification = self.datas[index];
    
    IWNotificationKnownParam *param = [[IWNotificationKnownParam alloc] init];
    param.loginId = [[IWUserTool user] loginId];
    param.notificationId = notification.ID;
    
    [IWMeTool notificationKnownWithParam:param success:^(IWBaseResult *result) {
        if (result.code == 0) {
            // 修改datas中的数据
            notification.status = 1;
            
            // 刷新
            [self.tableView reloadData];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"read_notification_error", nil)];
    }];
}


@end
