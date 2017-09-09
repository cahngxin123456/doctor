//
//  IWAddDataViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWAddDataViewController.h"
#import "IWMonitorAddDataHeaderView.h"
#import "IWMonitoeAddDataTableViewCell.h"
#import "IWAddDataWebViewViewController.h"
#import "IWAddDataPressBtnViewController.h"

@interface IWAddDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *myTableView;

@property (nonatomic, strong) NSArray *dataSourdce;

@end

@implementation IWAddDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
    if ([self.type isEqualToString:@"BloodPressure"]) {
        self.dataSourdce = @[NSLocalizedString(@"medical_monitor_pressure_list_1", nil),
                             NSLocalizedString(@"medical_monitor_pressure_list_2", nil),
                             NSLocalizedString(@"medical_monitor_pressure_list_3", nil),
                             NSLocalizedString(@"medical_monitor_pressure_list_4", nil)];
        [_myTableView reloadData];
        
    }else{
        self.dataSourdce = @[NSLocalizedString(@"medical_monitor_blood_list_1", nil),
                             NSLocalizedString(@"medical_monitor_blood_list_2", nil),
                             NSLocalizedString(@"medical_monitor_blood_list_3", nil)];
        [_myTableView reloadData];
    }
    [self myTableView];
    
}


- (void)setPressureModel:(IWBloodPressureModel *)pressureModel{
    _pressureModel = pressureModel;
}

- (void)setSugerModel:(IWBloodSugerModel *)sugerModel{
    _sugerModel = sugerModel;
}

- (void)setUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}


-(UITableView *)myTableView{
    if (_myTableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        tableView.backgroundColor=[UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled=NO;
        tableView.dataSource=self;
        tableView.delegate=self;
        if ([self.type isEqualToString:@"BloodPressure"]) {
            IWMonitorAddDataHeaderView *view = [IWMonitorAddDataHeaderView customViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) andTitle:@"BloodPressure"];
            [view setButtonBlock:^(NSString *text) {
                
                NSLog(@"血压监测");
                IWAddDataPressBtnViewController *vc = [[IWAddDataPressBtnViewController alloc] init];
                vc.memberId = self.memberId;
                vc.type = self.type;
                vc.navigationItem.title = @"血压监测";
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }];
            tableView.tableHeaderView = view;
            
            
        }else{
            IWMonitorAddDataHeaderView *view = [IWMonitorAddDataHeaderView customViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) andTitle:@"BloodSuger"];
            [view setButtonBlock:^(NSString *text) {
                NSLog(@"血糖监测");
                IWAddDataPressBtnViewController *vc = [[IWAddDataPressBtnViewController alloc] init];
                vc.memberId = self.memberId;
                vc.type = self.type;
                vc.navigationItem.title = @"血糖监测";
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }];
            tableView.tableHeaderView = view;
            
            
        }
        [self.view addSubview:tableView];
        _myTableView = tableView;
    }
    return _myTableView;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourdce.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IWMonitoeAddDataTableViewCell *cell = [IWMonitoeAddDataTableViewCell normalTableViewCellWithTableView:tableView];
    
    cell.nameTitle = self.dataSourdce[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat

{
    IWAddDataWebViewViewController *vc = [[IWAddDataWebViewViewController alloc] init];
    vc.navigationItem.title = NSLocalizedString(self.dataSourdce[indexPat.row], nil);
    vc.type = self.type;
    vc.indexPath = indexPat;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
