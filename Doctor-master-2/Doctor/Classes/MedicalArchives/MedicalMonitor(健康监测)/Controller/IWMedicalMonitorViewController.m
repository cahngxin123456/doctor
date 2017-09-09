//
//  IWMedicalMonitorViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWMedicalMonitorViewController.h"
#import "IWMonitorFirstTableViewCell.h"
#import "IWmOnitorSSTableViewCell.h"
#import "IWmOnitorTTTableViewCell.h"
#import "IWMonitorSecondTableViewCell.h"
#import "IWBloodPressureDataViewController.h"
#import "IWBloodSugerDataViewController.h"
#import "IwMedicalMonitorDetalViewController.h"
#import "IWBloodPressureModel.h"
#import "IWBloodSugerModel.h"
#import "IWAddDataViewController.h"
#import "IWPressureAndSugerDetailViewController.h"
#import "IWMedicalMointorSugarListViewController.h"

@interface IWMedicalMonitorViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *myTableView;

@property (nonatomic, strong) IWBloodPressureModel *pressureModel;
@property (nonatomic, strong) IWBloodSugerModel *sugerModel;

@end

@implementation IWMedicalMonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    [self myTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = NSLocalizedString(@"健康监测",nil);
    
    [self loadData];
}

- (void)loadData
{

    NSNumber *companyId = @(IWCompanyId);
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSString *memberId = self.memberId;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:memberId forKey:@"memberId"];
    //血压
    [IWHttpTool postWithURL:SERVER_GET_LASTED_BLOOD_PRESSURE_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {

            
            NSDictionary *tempDic = json[@"datas"];
            
            if ([tempDic isKindOfClass:[NSDictionary class]]) {
                self.pressureModel = [[IWBloodPressureModel alloc] init];
                [self.pressureModel setValuesForKeysWithDictionary:tempDic];
                [self.myTableView reloadData];
            }
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    //血糖
    [IWHttpTool postWithURL:SERVER_GET_LASTED_BLOOD_SUGAR_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            if ([json[@"datas"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *tempDic = json[@"datas"];
                self.sugerModel = [[IWBloodSugerModel alloc] init];
                [self.sugerModel setValuesForKeysWithDictionary:tempDic];
                [self.myTableView reloadData];

            }
        }
    } failure:^(NSError *error) {
        
    }];


}

#pragma mark - 懒加载控件

- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _myTableView = tableView;
    }
    return _myTableView ;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.pressureModel.pressureID) {
            return 3;
        }else{
            return 0;
        }
    }else{
        if (self.sugerModel.sugerID) {
            return 1;
        }else{
            return 0;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            return 160 *SFXISHU;
        }else if (indexPath.row==1){
            return 110 *SFXISHU;
        }else
        {
            return 120*SFXISHU;
        }
    }else{
        return 149*SFXISHU;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            IWMonitorFirstTableViewCell *cell = [IWMonitorFirstTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;
            return cell;
        }else if (indexPath.row == 1){
            
            IWmOnitorSSTableViewCell *cell = [IWmOnitorSSTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;

            return cell;
        }else{
            IWMonitorTTTableViewCell *cell = [IWMonitorTTTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;

            return cell;
        }
    }else{
        
        IWMonitorSecondTableViewCell *cell = [IWMonitorSecondTableViewCell normalTableViewCellWithTableView:tableView StrResource:@"2"];
        cell.model = self.sugerModel;
        return cell;
        
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        IWPressureAndSugerDetailViewController *vc = [[IWPressureAndSugerDetailViewController alloc] init];
        vc.navigationItem.title = @"血压监测详情";
        vc.isShowresurvey = NO;
        vc.pressureModel = self.pressureModel;
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        IWPressureAndSugerDetailViewController *vc = [[IWPressureAndSugerDetailViewController alloc] init];
        vc.navigationItem.title = @"血糖监测详情";
        vc.isShowresurvey = NO;
        vc.sugerModel = self.sugerModel;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    
    
    
    
}



//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(10, 5, self.view.frame.size.width - 20, 50);
    [backView addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(8, 0, 100, 40);
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    if (section == 0) {
        label.text = @"血压";
    }else{
        label.text = @"血糖";
    }
    
    [view addSubview:label];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(view.frame.size.width - 90, 5, 70, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitle:@"数据统计" forState:UIControlStateNormal];
    [btn setTitleColor:IWColor(22,154,255) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(headerButtonCliclked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section;
    
    
    [view addSubview:btn];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(view.frame.size.width - 18, (40 - 13)/2, 12, 12);
    imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
    [view addSubview:imageView];
    
    //细线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.2;
    lineView.frame = CGRectMake(0, 40, view.frame.size.width, 0.5);
    [view addSubview:lineView];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    if (section == 0) {
        if (self.pressureModel.measureTime.length == 0) {
            timeLabel.text = @"";
        }else{
            timeLabel.text = [NSString stringWithFormat:@"测于：%@",self.pressureModel.measureTime];
        }

    }else{
        if (self.sugerModel.measureTime.length == 0) {
            timeLabel.text = @"";
        }else{
            timeLabel.text = [NSString stringWithFormat:@"测于：%@",self.sugerModel.measureTime];

        }
    }
    
    timeLabel.frame = CGRectMake(10, lineView.frame.origin.y + 1, 200, 30);
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = IWColor(22,154,255);
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.backgroundColor = [UIColor whiteColor];
    [view addSubview:timeLabel];
    
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(10, 0, self.view.frame.size.width - 20 , 40);
    btn.backgroundColor = IWColor(248, 248, 248);
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"添加新纪录" forState:UIControlStateNormal];
    [btn setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(footerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = section + 1;
    [backView addSubview:btn];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}


#pragma mark - 按钮点击事件

- (void)headerButtonCliclked:(UIButton *)btn
{
    NSLog(@"headerButtonCliclked");
    UIButton *button = btn;
    if (button.tag == 0) {
  
        
        IWBloodPressureDataViewController *vc = [[IWBloodPressureDataViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"medical_monitor_list_title", nil);
        vc.memberId = self.memberId;
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        IWMedicalMointorSugarListViewController *vc = [[IWMedicalMointorSugarListViewController alloc] init];
        vc.memberId = self.memberId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)footerBtnClicked:(UIButton *)btn
{
    NSLog(@"footerBtnClicked");
    UIButton *button = btn;
    
    if (button.tag == 1) {
        
        IWAddDataViewController *vc = [[IWAddDataViewController alloc] init];
        vc.memberId = self.memberId;
        vc.type = @"BloodPressure";
        vc.pressureModel = self.pressureModel;
        vc.navigationItem.title = NSLocalizedString(@"medical_monitor_pressure_title", nil);
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else{
        IWAddDataViewController *vc = [[IWAddDataViewController alloc] init];
        vc.memberId = self.memberId;
        vc.type = @"BloodSuger";
        vc.sugerModel = self.sugerModel;
        vc.navigationItem.title = NSLocalizedString(@"medical_monitor_blood_title", nil);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
