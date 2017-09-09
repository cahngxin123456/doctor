//
//  IWHelpViewController.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHelpViewController.h"
#import "IWMeTool.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWHelpResult.h"
#import "MJRefresh.h"
#import "IWHelp.h"
#import "IWHelpCell.h"
#import "IWHelpDetailViewController.h"
#import "IWUserFeedbackViewController.h"

@interface IWHelpViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWHelpResult *result;
@property (nonatomic, assign) int currentPageNumber;
@end

@implementation IWHelpViewController

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
    self.title = NSLocalizedString(@"help", nil);
    self.tableView.rowHeight = 44;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
}

/**
 *  搜索
 */
- (void)add:(UIBarButtonItem *)item {
    IWUserFeedbackViewController *addVC = [[IWUserFeedbackViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
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
    double number = (double)self.result.totalCount / 50;
    IWLog(@"%f", number);
    if (self.currentPageNumber > (int)ceil(number)) {
        [self.footer endRefreshing];
        return;
    }
    
    IWHelpParam *param = [[IWHelpParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(50);
    
    [IWMeTool helpWithParam:param success:^(IWHelpResult *result) {
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
    IWHelpParam *param = [[IWHelpParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(50);
    
    [IWMeTool helpWithParam:param success:^(IWHelpResult *result) {
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
    IWHelpCell *cell = [IWHelpCell cellWithTableView:tableView];
    
    // 2.传递frame模型
    cell.help = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 进入详情页面
    IWHelpDetailViewController *vc = [[IWHelpDetailViewController alloc] init];
    vc.help = self.datas[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
