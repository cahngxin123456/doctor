//
//  IWSecondChildViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWSecondChildViewController.h"
#import "IWInquiryViewCell.h"
#import "IWInquiryFirstViewCell.h"
#import "IWInquiryTool.h"
#import "IWGetInquiryParam.h"
#import "IWGetInquiryResult.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "IWInquiryDetailViewController.h"


@interface IWSecondChildViewController ()<UITableViewDataSource,UITableViewDelegate, MJRefreshBaseViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) IWGetInquiryResult *result;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@property (nonatomic, assign) int currentPageNumber;

@end

@implementation IWSecondChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    // 集成刷新控件
    [self setupRefreshView];
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
    double number = (double)self.result.totalCount / 10;
    IWLog(@"%f", number);
    if (self.currentPageNumber > (int)ceil(number)) {
        [self.footer endRefreshing];
        return;
    }
    
    IWGetInquiryParam *param = [[IWGetInquiryParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.inquiryType = self.inquiryType;
    param.inquiryStatus = 1;//tijiao
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(10);
    
    [IWInquiryTool inquiryListWithParam:param success:^(IWGetInquiryResult *result) {
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
    IWGetInquiryParam *param = [[IWGetInquiryParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.inquiryType = self.inquiryType;
    param.inquiryStatus = 1;//tijiao
    param.pageNumber = @(self.currentPageNumber);
    param.pageSize = @(10);
    
    [IWInquiryTool inquiryListWithParam:param success:^(IWGetInquiryResult *result) {
        self.result = result;
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:result.pageData];
        self.datas = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
        self.tableView.tableHeaderView.hidden = NO;
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

-(UITableView *)tableView{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        
        if (self.inquiryType == 0 || self.inquiryType == 1 || self.inquiryType == 2) {
            tableView.frame = CGRectMake(0, 0, IWWIDTH, IWHEIGHT- 64);
        }else{
            tableView.frame = CGRectMake(0, 0, IWWIDTH, IWHEIGHT- 230 - 20);
        }
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled=YES;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:tableView];
        _tableView = tableView;

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    // 1.创建cell
//    IWInquiryViewCell *cell = [IWInquiryViewCell cellWithTableView:tableView];
//    cell.statusType = 1;
//    // 2.传递frame模型
//    cell.inqurity = self.datas[indexPath.row];
//    
//    return cell;
    // 1.创建cell
    IWInquiryFirstViewCell *cell = [IWInquiryFirstViewCell cellWithTableView:tableView];
    cell.statusType = 1;
    // 2.传递frame模型
    cell.inqurity = self.datas[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    id model = self.datas[indexPath.row];
//    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"inqurity" cellClass:[IWInquiryViewCell class] contentViewWidth:[self cellContentViewWith]];
    IWInquiryFirstViewCell* cell = (IWInquiryFirstViewCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    CGFloat cellHeight = [cell cellHeight];
    return cellHeight;
}

- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IWInquiryDetailViewController *vc = [[IWInquiryDetailViewController alloc] init];
    vc.navigationItem.title = @"留言问诊";
    vc.inquiry = self.datas[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
