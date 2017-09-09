//
//  IWBloodPressureDataViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodPressureDataViewController.h"
#import "IWBloodPressureHeaderView.h"
#import "IwBloodPressureDataTableViewCell.h"
#import "IWBloodPressureDetalModel.h"

@interface IWBloodPressureDataViewController ()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) IWBloodPressureHeaderView *headerView;

@property (nonatomic, weak) MJRefreshFooterView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) NSInteger currentPageNumber;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) long totalCount;


@end

@implementation IWBloodPressureDataViewController

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
    
    // 集成刷新控件
    [self setupRefreshView];
    
    
    //懒加载
    [self tableView];
    [self headerView];
}

/**
 *  设置基本
 */
- (void)setupBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSMutableArray arrayWithCapacity:0];

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
        double number = ((double)self.totalCount)/ IWPAGESIZE;
        IWLog(@"%f", number);
        if (self.currentPageNumber > number) {
            [self.footer endRefreshing];
            return;
        }

    
    NSNumber *companyId = @(IWCompanyId);
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSString *memberId = self.memberId;
    NSNumber *pageNumber = @(self.currentPageNumber);
    NSNumber *pageSize = @(IWPAGESIZE);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:memberId forKey:@"memberId"];
    [params setValue:pageNumber forKey:@"pageNumber"];
    [params setValue:pageSize forKey:@"pageSize"];
    //血压
    [IWHttpTool postWithURL:SERVER_GET_BLOOD_PRESSURE_LIST_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            NSDictionary *tempDic = json[@"datas"];
            
            NSArray *pageData = tempDic[@"pageData"];
            self.totalCount = [tempDic[@"totalCount"] doubleValue];
            for (NSDictionary *subDic in pageData) {
                IWBloodPressureDetalModel *model = [[IWBloodPressureDetalModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
            [self.footer endRefreshing];
        }else{
//            [IWToast toastWithView:self.view title:result.info];
//            [self.datas removeAllObjects];
            [self.tableView reloadData];
            
        }
        
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        [self.tableView reloadData];
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];

}

/**
 *  加载数据
 */
- (void)loadNewData {
    
    //获取血压记录数据
    NSNumber *companyId = @(IWCompanyId);
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSString *memberId = self.memberId;
    NSNumber *pageNumber = @(self.currentPageNumber);
    NSNumber *pageSize = @(IWPAGESIZE);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:memberId forKey:@"memberId"];
    [params setValue:pageNumber forKey:@"pageNumber"];
    [params setValue:pageSize forKey:@"pageSize"];
    //血压
    [IWHttpTool postWithURL:SERVER_GET_BLOOD_PRESSURE_LIST_URL params:params success:^(id json) {
        if ([json[@"code"] intValue] == 0) {

            NSDictionary *tempDic = json[@"datas"];
            NSArray *pageData = tempDic[@"pageData"];
            self.totalCount = [tempDic[@"totalCount"] doubleValue];
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subDic in pageData) {
                IWBloodPressureDetalModel *model = [[IWBloodPressureDetalModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [tempArray addObject:model];
            }
            self.dataSource = [[NSMutableArray alloc] initWithArray:tempArray];
            [self.tableView reloadData];
        }else{
//            [IWToast toastWithView:self.view title:result.info];
//            [self.datas removeAllObjects];
            [self.tableView reloadData];

        }
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        [self.tableView reloadData];
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (IWBloodPressureHeaderView *)headerView{
    if (_headerView == nil) {
        IWBloodPressureHeaderView *view = [IWBloodPressureHeaderView customViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        [self.view addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 - 64) style:UITableViewStyleGrouped];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWBloodPressureDetalModel *model = self.dataSource[indexPath.section];

    if (model.remark !=nil && model.remark.length>0 ) {
        return  80;
    }
    else{
    return 40;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IwBloodPressureDataTableViewCell *cell = [IwBloodPressureDataTableViewCell normalTableViewCellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.section];
    
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //消除cell选择痕迹
//    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.2];
//}
//- (void)deselect
//{
//    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//}
//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        IWBloodPressureHeaderView *view = [IWBloodPressureHeaderView customViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
//        return view;
//    }else{
//        return nil;
//    }

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 40;
//    }else{
//        return 0.001;
//    }
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = IWTableViewBgColor;
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
