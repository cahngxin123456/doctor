//
//  IWMedicalReportViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWMedicalReportViewController.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "IWMedicalArchivesTool.h"
#import "IWMedicalReportViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "IWMedicalReportAddViewController.h"
#import "IWToast.h"

#import "IWAddHeightParam.h"
#import "IWMedicalReportAddViewController.h"

@interface IWMedicalReportViewController () <MJRefreshBaseViewDelegate, UITableViewDataSource, UITableViewDelegate, IWMedicalReportViewCellDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, strong) IWMedicalReport *medicalReport;

@property (nonatomic, strong) IWGetMedicalReportListResult *result;
@property (nonatomic, assign) int currentPageNumber;

@end

@implementation IWMedicalReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    // 设置tableView属性
    [self setupTableView];
    
    // 添加按钮
    [self setupButton];
    
    // 集成刷新控件
    [self setupRefreshView];
}

-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


/**
 *  设置tableView属性
 */
- (void)setupTableView {
    self.title = NSLocalizedString(@"medical_archives_2", nil);
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableView.separatorColor = IWColorWithAlpha(204, 204, 204, 0.2);
    tableView.backgroundColor = IWTableViewBgColor;
    tableView.showsHorizontalScrollIndicator=NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    int margin = 4;
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, kWidth, 0);
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = NSLocalizedString(@"inquiry_report_tip", nil);
    tipLabel.font = [UIFont systemFontOfSize:11];
    tipLabel.numberOfLines = 0;
    tipLabel.textColor = IWBlueColor;
    CGFloat tipLabelX = margin;
    CGFloat tipLabelY = margin;
    CGFloat tipLabelW = kWidth - 2 * margin;
    CGSize tipLabelSize = [tipLabel.text sizeWithFont:tipLabel.font constrainedToSize:CGSizeMake(tipLabelW, MAXFLOAT)];
    tipLabel.frame = (CGRect){{tipLabelX, tipLabelY}, tipLabelSize};
    headerView.height = CGRectGetMaxY(tipLabel.frame);
    [headerView addSubview:tipLabel];
    
    if (self.isFromInquiry) {
        self.tableView.tableHeaderView = headerView;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"doctor_ok", nil) style:UIBarButtonItemStyleDone target:self action:@selector(setButtonOk)];
    }
}

- (void)setButtonOk {
    if (_fromeControllerBlock) {
        // 找到选择的
        NSMutableArray *reports = [[NSMutableArray alloc] init];
        for (IWMedicalReport *r in self.datas) {
            if (r.isChecked) {
                [reports addObject:r];
            }
        }
        _fromeControllerBlock(reports);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 添加按钮
 */
- (void)setupButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = 20;
    CGFloat width = 60;
    CGFloat height = width;
    CGFloat x = self.view.frame.size.width - width - margin;
    CGFloat y = self.view.frame.size.height - height - 4 * margin;
    button.frame = CGRectMake(x, y, width, height);
    [button setBackgroundImage:[UIImage imageWithName:@"liuyan_btn"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:@"liuyan_btn_highlighted"] forState:UIControlStateHighlighted];
    [button setTitle:NSLocalizedString(@"medical_archives_add_report", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.numberOfLines = 0;
    [button addTarget:self action:@selector(addReport) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:button];
}

- (void)addReport {
    IWMedicalReportAddViewController *add = [[IWMedicalReportAddViewController alloc] init];
    add.memberId = self.memberId;
    [self.navigationController pushViewController:add animated:YES];
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
    
    IWGetMedicalReportListParam *param = [[IWGetMedicalReportListParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.memberId = self.memberId;
    
    [IWMedicalArchivesTool medicalReportListWithParam:param success:^(IWGetMedicalReportListResult *result) {
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
    IWGetMedicalReportListParam *param = [[IWGetMedicalReportListParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.memberId = self.memberId;

    [IWMedicalArchivesTool medicalReportListWithParam:param success:^(IWGetMedicalReportListResult *result) {
        self.result = result;
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:result.pageData];
        self.datas = tempArray;
        
        if (self.isFromInquiry && self.reports != nil && self.reports.count > 0) {
            for (IWMedicalReport *report in self.datas) {
                for (IWMedicalReport *r in self.reports) {
                    if ([report.ID isEqualToString:r.ID]) {
                        report.isChecked = YES;
                    }
                }
            }
        }
        
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

- (void)didClickDeleteButton:(IWMedicalReport *)medicalReport {
    self.medicalReport = medicalReport;
    if (medicalReport.isShowDetail) {
        IWMedicalReportAddViewController *add = [[IWMedicalReportAddViewController alloc] init];
        add.memberId = self.memberId;
        add.medicalReportModel = medicalReport;
        [self.navigationController pushViewController:add animated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"inquiry_family_delete_title", nil) message:NSLocalizedString(@"inquiry_family_delete_content", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"inquiry_family_delete_cancel", nil) otherButtonTitles:NSLocalizedString(@"inquiry_family_delete_ok", nil), nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        return;
    }
    IWDeleteMedicalReportParam *param = [[IWDeleteMedicalReportParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.reportId = self.medicalReport.ID;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWMedicalArchivesTool deleteMedicalReportWithParam:param success:^(IWBaseResult *result) {
        // 隐藏加载框
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"delete_success", nil)];
            [self.datas removeObject:self.medicalReport];
            [self.tableView reloadData];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
    } failure:^(NSError *error) {
        // 隐藏加载框
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:NSLocalizedString(@"delete_fail", nil)];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    IWMedicalReportViewCell *cell = [IWMedicalReportViewCell cellWithTableView:tableView];
    cell.delegate = self;
    // 2.传递frame模型
    cell.isFromInquiry = self.isFromInquiry;
    cell.medicalReport = self.datas[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = self.datas[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"medicalReport" cellClass:[IWMedicalReportViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选择
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IWMedicalReport *medicalReport = self.datas[indexPath.row];
    if (self.isFromInquiry) {
        medicalReport.isChecked = !medicalReport.isChecked;
        [self.tableView reloadData];
    } else {
        // 进入详情页面
        IWMedicalReportAddViewController *add = [[IWMedicalReportAddViewController alloc] init];
        add.memberId = self.memberId;
        add.medicalReportModel = medicalReport;
        
        [self.navigationController pushViewController:add animated:YES];
    }
    
    
}

@end
