//
//  IWHealthFileViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/18.
//
//

#import "IWHealthFileViewController.h"
#import "IWHealthFileTableViewCell.h"
#import "IWMedicalInfoViewController.h"
#import "IWMedicalReportViewController.h"
#import "IWMedicalMonitorViewController.h"
#import "IWProfileInfoViewController.h"
#import "IWHealhFileModel.h"


@interface IWHealthFileViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

@property (nonatomic, weak) UITableView *healthFileTabelView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, weak) UIButton *bottomButton;

@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) int currentPageNumber;

@end

@implementation IWHealthFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = IWTableViewBgColor;
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self healthFileTabelView];

    //懒加载控件
    [self bottomButton];

    //请求数据
    [self setupRefreshView];
}

/**
 *  集成刷新控件
 */
- (void)setupRefreshView {
    // 1. 下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.healthFileTabelView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    // 2. 上拉刷新(上拉加载更多数据)
//    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
//    footer.scrollView = self.healthFileTabelView;
//    footer.delegate = self;
//    self.footer = footer;
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
//        self.currentPageNumber++;
//        [self loadMoreData];
    } else { // 下拉刷新
        self.currentPageNumber = 1;
        [self loadNewData];
    }
}

/**
 *  发送请求加载更多的微博数据
 */
//- (void)loadMoreData {
//    // 计算当前的页码
//    double number = (double)self.result.totalCount / IWPAGESIZE;
//    IWLog(@"%f", number);
//    if (self.currentPageNumber > (int)ceil(number)) {
//        [self.footer endRefreshing];
//        return;
//    }
//    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
//    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
//    [params setValue:loginID forKey:@"loginId"];
//    [params setValue:@"3" forKey:@"relationship"];
//    [IWHttpTool postWithURL:SERVER_GET_GET_MEMBER_LIST_URL params:params success:^(id json) {
//        if ([json[@"code"] intValue] == 0) {
//            NSArray *tempArray = json[@"datas"];
//            for (NSDictionary *subDic in tempArray) {
//                IWHealhFileModel *model = [[IWHealhFileModel alloc] init];
//                [model setValuesForKeysWithDictionary:subDic];
//                [self.dataSource addObject:model];
//                [self.healthFileTabelView reloadData];
//            }
//        }
//    
//        // 刷新表格
//        [self.tableView reloadData];
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//    } failure:^(NSError *error) {
//        IWLog(@"%@", error);
//        // 让刷新控件停止显示刷新状态
//        [self.header endRefreshing];
//    }];
//}

/**
 *  加载数据
 */
- (void)loadNewData {
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:@"3" forKey:@"relationship"];
    [IWHttpTool postWithURL:SERVER_GET_GET_MEMBER_LIST_URL params:params success:^(id json) {
        if ([json[@"code"] intValue] == 0) {
            [self.dataSource removeAllObjects];
            
            NSArray *tempArray = json[@"datas"];
            
            for (NSDictionary *subDic in tempArray) {
                IWHealhFileModel *model = [[IWHealhFileModel alloc] init];
                [model setValuesForKeysWithDictionary:subDic];
                [self.dataSource addObject:model];
                [self.healthFileTabelView reloadData];
            }
        }
        // 刷新表格
        [self.healthFileTabelView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];

        
        
    } failure:^(NSError *error) {
        
        IWLog(@"%@", error);
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];

        
    }];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = NSLocalizedString(@"健康档案",nil);
}



-(UIButton *)bottomButton{
    if (_bottomButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(IWWIDTH - 70, IWHEIGHT - 70 - 64, 60, 60);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 25;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(bottombuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.numberOfLines = 2;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"liuyan_btn"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"liuyan_btn_highlighted"] forState:UIControlStateHighlighted];
        
        [button setTitle:@"添加\n人员" forState:UIControlStateNormal];
        
        [self.view addSubview:button];
        
        _bottomButton=button;
    }
    return _bottomButton;
}
//点击事件
-(void)bottombuttonClicked:(UIButton *)button{
    IWProfileInfoViewController *vc = [[IWProfileInfoViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.modelId = @"kong";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UITableView *)healthFileTabelView
{
    if (_healthFileTabelView == nil) {
        UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, IWWIDTH, IWHEIGHT - 64) style:UITableViewStylePlain];
        tabelView.delegate = self;
        tabelView.dataSource = self;
        tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabelView.backgroundColor = IWTableViewBgColor;
        tabelView.showsHorizontalScrollIndicator=NO;
        tabelView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tabelView];
        
        _healthFileTabelView = tabelView;
    }
    return _healthFileTabelView;
}


#pragma mark - tableview的代理方法


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IWHealthFileTableViewCell *cell = [IWHealthFileTableViewCell normalTableViewCellWithTableView:tableView];
    __weak typeof(self) ws = self;
    
    [cell setFirstBtnBlock:^{
        
        IWMedicalMonitorViewController *vc = [[IWMedicalMonitorViewController alloc] init];
        vc.memberId = [self.dataSource[indexPath.section] memberId];
        [ws.navigationController pushViewController:vc animated:YES];
    }];
    
    [cell setSecondBtnBlock:^{
        IWMedicalReportViewController *vc = [[IWMedicalReportViewController alloc] init];
        vc.memberId = [self.dataSource[indexPath.section] memberId];
        [ws.navigationController pushViewController:vc animated:YES];
        
    }];
    
    [cell setThirdBtnBlock:^{
        
        IWMedicalInfoViewController *vc = [[IWMedicalInfoViewController alloc] init];
        
        vc.memberId = [self.dataSource[indexPath.section] memberId];

        [ws.navigationController pushViewController:vc animated:YES];
    }];
    
    
    cell.model = self.dataSource[indexPath.section];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = IWTableViewBgColor;
    view.frame = CGRectMake(0, 0, self.view.frame.size.width, 10);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if ([self.fromeController isEqualToString:@"IWAddMessageViewController"]) {
        IWHealhFileModel *model = self.dataSource[indexPath.section];
        
        if (_fromeControllerBlock) {

            _fromeControllerBlock(model.memberId,model.name);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        IWProfileInfoViewController *vc = [[IWProfileInfoViewController alloc] init];
        vc.modelId = [self.dataSource[indexPath.section] memberId];
        vc.relationship = [self.dataSource[indexPath.section] relationship];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
