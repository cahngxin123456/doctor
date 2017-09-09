//
//  IWMedicalMointorSugarListViewController.m
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import "IWMedicalMointorSugarListViewController.h"
#import "IWMedicalArchivesTool.h"
#import "IWMedicalMointorSugarTableViewCell.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#define KOrigin1 100.0/375* [UIScreen mainScreen].bounds.size.width
#define KOrigin2 20
#define KOrigin3 60
@interface IWMedicalMointorSugarListViewController ()<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayOfData;


@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;

@property (nonatomic, assign) int currentPageNumber;
@property (nonatomic, strong) IWGetMedicalSugarListResult *result;


@end

@implementation IWMedicalMointorSugarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    self.currentPageNumber = 1;

    self.title = @"血糖监测统计";
    self.arrayOfData = [[NSMutableArray alloc] init];
//    [self loadData];
    [self myTableView];
    
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
        [self loadData];
    } else { // 下拉刷新
        self.currentPageNumber = 1;
        [self loadData];
    }
}


#pragma mark --- 数据请求
- (void)loadData
{
    
    // 计算当前的页码
    if (self.result.totalCount >0 && self.currentPageNumber > 1) {
        double number = (double)self.result.totalCount / IWPAGESIZE;
        IWLog(@"%f", number);
        if (self.currentPageNumber > (int)ceil(number)) {
            [self.footer endRefreshing];
            return;
        }
    }

//    if (self.result.totalCount >0 && self.currentPageNumber > 1) {
//        if (self.currentPageNumber * IWPAGESIZE > self.result.totalCount) {
//            [self.footer endRefreshing];
//            return;
//        }
//    }
    

    IWGetMedicalSugarListParam *params = [[IWGetMedicalSugarListParam alloc] init];
    params.pageNumber = [NSNumber numberWithInt:self.currentPageNumber];
    params.companyId = @(IWCompanyId);
    params.loginId = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    params.memberId = self.memberId;
    params.pageSize = @(IWPAGESIZE);
    //
    [IWMedicalArchivesTool getMedicalSugarListListWithParam:params success:^(IWGetMedicalSugarListResult *result) {
        NSArray *temparray = result.pageData;
        if ([temparray isKindOfClass:[NSArray class]] && temparray.count>0) {
            self.result = result;

            if (self.currentPageNumber ==1) {
                [self.arrayOfData removeAllObjects];
                self.arrayOfData = [[NSMutableArray alloc] init];

                self.arrayOfData = [[NSMutableArray alloc] initWithArray:temparray];
                
                [self.header endRefreshing];
                
            }
            else{
                [self.arrayOfData addObjectsFromArray:temparray];
                [self.footer endRefreshing];
                
                
            }
            [self.tableView reloadData];
        }
        else{
            [self.header endRefreshing];
            [self.footer endRefreshing];

        }
        

    
    } failure:^(NSError *error) {
        if (self.currentPageNumber ==1) {
            [self.header endRefreshing];
            
        }
        else{
            [self.footer endRefreshing];
            
        }

    }];
        
}


#pragma mark -- 创建UI

#pragma mark - 懒加载控件

- (UITableView *)myTableView
{
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}

#pragma mark --UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfData.count +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 70;
    if (indexPath.row>0) {
        IWBloodSugerModel *model = [self.arrayOfData objectAtIndex:indexPath.row-1];
        if (model.remark != nil && model.remark.length>0) {
            height = 96;
        }


    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
        }
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.text = @"6.0mmol/L";
        lb1.textColor = IWGreenColor;
        [lb1 setFont:[UIFont systemFontOfSize:18]];
    CGRect bounds = [lb1.text getTextWidthAndHeightWithFont:18 withWidth:999999];
        
        CGFloat distance=45;
        if ([UIScreen mainScreen].bounds.size.width ==320) {
            distance=65;
        }
        else if ([UIScreen mainScreen].bounds.size.width ==375)
        {
            distance=100;
        }
        else if ([UIScreen mainScreen].bounds.size.width >375)
        {
            distance=110;
        }

    lb1.frame = CGRectMake(distance, 0, bounds.size.width, bounds.size.height);
    [cell.contentView addSubview:lb1];
    UILabel *lb11 = [[UILabel alloc] init];
    lb11.frame = CGRectMake(CGRectGetMaxX(lb1.frame), lb1.frame.origin.y+4, 1,(70-lb1.frame.origin.y-4));
    lb11.backgroundColor = IWGreenColor;
    [cell.contentView addSubview:lb11];
    
    
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.text = @"7.8mmol/L";
    lb2.textColor = IWGreenColor;
    [lb2 setFont:[UIFont systemFontOfSize:18]];
    CGRect bounds2 = [lb2.text getTextWidthAndHeightWithFont:18 withWidth:999999];
    lb2.frame = CGRectMake(distance - KOrigin2, CGRectGetMaxY(lb1.frame)+16, bounds2.size.width, bounds2.size.height);
    [cell.contentView addSubview:lb2];
    UILabel *lb22 = [[UILabel alloc] init];
    lb22.frame = CGRectMake(CGRectGetMaxX(lb2.frame), lb2.frame.origin.y+4, 1,(70-lb2.frame.origin.y-4));
    lb22.backgroundColor = IWGreenColor;
    [cell.contentView addSubview:lb22];
    
    UILabel *lb3 = [[UILabel alloc] init];
    lb3.text = @"3.9mmol/L";
    lb3.textColor = IWGreenColor;
    [lb3 setFont:[UIFont systemFontOfSize:18]];
    CGRect bounds3 = [lb3.text getTextWidthAndHeightWithFont:18 withWidth:999999];
    lb3.frame = CGRectMake(KOrigin3+CGRectGetMaxX(lb1.frame), lb2.frame.origin.y, bounds3.size.width, bounds3.size.height);
    [cell.contentView addSubview:lb3];
    UILabel *lb33 = [[UILabel alloc] init];
    lb33.frame = CGRectMake(lb3.frame.origin.x-1, lb3.frame.origin.y+4, 1,(70-lb3.frame.origin.y-4));
    lb33.backgroundColor = IWGreenColor;
    [cell.contentView addSubview:lb33];
    
    

    
    
        return cell;
        
    }
    else{
        IWMedicalMointorSugarTableViewCell *cell = [IWMedicalMointorSugarTableViewCell normalTableViewCellWithTableView:tableView];
        cell.model = [self.arrayOfData objectAtIndex:indexPath.row-1];
        return cell;
        
    }
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
