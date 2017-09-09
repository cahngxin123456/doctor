//
//  IWNewsViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNewsViewController.h"
#import "IWCompanyTool.h"
#import "MJRefresh.h"
#import "IWNews.h"
#import "IWNavigationController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"

@interface IWNewsViewController () <MJRefreshBaseViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) int currentPageNumber;
@end

@implementation IWNewsViewController

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
    self.title = NSLocalizedString(@"news", nil);
    self.tableView.rowHeight = 80;
    self.tableView.backgroundColor = IWTableViewBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    UIBarButtonItem *more = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithName:@"more_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
    
    self.navigationItem.rightBarButtonItems = @[more, search];
}

/**
 *  更多内容
 */
- (void)more:(UIBarButtonItem *)item {

}

/**
 *  搜索
 */
- (void)search:(UIBarButtonItem *)item {
    
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
//    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) { // 上拉刷新
//        self.currentPageNumber++;
//        [self loadMoreData];
//    } else { // 下拉刷新
//        self.currentPageNumber = 1;
//        [self loadNewData];
//    }
}





@end
