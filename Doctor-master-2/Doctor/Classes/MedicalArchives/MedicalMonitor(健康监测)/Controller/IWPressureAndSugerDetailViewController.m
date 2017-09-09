//
//  IWPressureAndSugerDetailViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/30.
//
//

#import "IWPressureAndSugerDetailViewController.h"
#import "IWMonitorFirstTableViewCell.h"
#import "IWmOnitorSSTableViewCell.h"
#import "IWMonitorTTTableViewCell.h"
#import "IWMonitorSecondTableViewCell.h"
#import "IWHttpTool.h"
#import "IWMedicalArchivesTool.h"
#import "IWDeletePressureDetailParam.h"
#import "IWDeleteSugerDetailModel.h"
#import "TPKeyboardAvoidingTableView.h"
#import "IWAddDataPressBtnViewController.h"

@interface IWPressureAndSugerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;

@end

@implementation IWPressureAndSugerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    
    //得到当前视图控制器中的所有控制器
    NSMutableArray *array = [self.navigationController.viewControllers mutableCopy];
    for (int i=0; i<array.count; i++) {
        UIViewController *vc = self.navigationController.viewControllers[i];
        if ([vc isKindOfClass:[IWAddDataPressBtnViewController class]]) {
            [array removeObject:vc];
        }
    }
    
    //把删除后的控制器数组再次赋值
    [self.navigationController setViewControllers:[array copy] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPressureModel:(IWBloodPressureModel *)pressureModel{
    _pressureModel = pressureModel;
}

- (void)setSugerModel:(IWBloodSugerModel *)sugerModel{
    _sugerModel = sugerModel;
}

- (TPKeyboardAvoidingTableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:self.view.bounds];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
    
        tableView.scrollEnabled = YES;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.pressureModel) {
        return 3;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pressureModel) {
        if (indexPath.row==0) {
            return 160 * SFXISHU;
        }else if (indexPath.row==1){
            return 110 * SFXISHU;
        }else
        {
            return 120 *SFXISHU;
        }
    }else{
        return 149*SFXISHU;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pressureModel ) {
        if (indexPath.row == 0) {
            
            IWMonitorFirstTableViewCell *cell = [IWMonitorFirstTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;
            return cell;
        }else if (indexPath.row == 1){
            
            IWmOnitorSSTableViewCell *cell = [IWmOnitorSSTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;
            
            return cell;
        }else{
            
            IWMonitorTTTableViewCell*cell = [IWMonitorTTTableViewCell normalTableViewCellWithTableView:tableView];
            cell.model = self.pressureModel;
            
            return cell;
        }
    }else{
        IWMonitorSecondTableViewCell *cell = [IWMonitorSecondTableViewCell normalTableViewCellWithTableView:tableView StrResource:@"1"];
        cell.model = self.sugerModel;
        return cell;
    }
    
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
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = IWFont;
    label.frame = CGRectMake(10, 0, IWWIDTH, 30);
    label.textColor = IWBlueColor;
    label.textAlignment=NSTextAlignmentLeft;
    if (self.pressureModel) {
        label.text = self.pressureModel.measureTime;
    }else{
        label.text = self.sugerModel.measureTime;
    }
    [backView addSubview:label];
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    UIButton *button = [[UIButton alloc] init];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.frame = CGRectMake(10, 20, IWWIDTH - 20, 40);
    [button setTitle:@"删除" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button setBackgroundColor: [UIColor orangeColor]];
    button.titleLabel.font = IWFont;
    [button addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.isShowresurvey) {
        UIButton *button2 = [[UIButton alloc] init];
        button2.layer.masksToBounds = YES;
        button2.layer.cornerRadius = 3;
        button2.frame = CGRectMake(10, CGRectGetMaxY(button.frame)+20, IWWIDTH - 20, 40);
        [button2 setTitle:@"重测" forState:UIControlStateNormal];
        [button2 setTintColor:[UIColor whiteColor]];
        [button2 setBackgroundColor:IWColor(30, 180, 162)];
        button2.titleLabel.font = IWFont;
        [button2 addTarget:self action:@selector(BackClicked:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button2];

 
    }
       [backView addSubview:button];

    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 110;
}

- (void)cancelButtonClicked:(UIButton *)btn{
    if (self.pressureModel) {
        IWDeletePressureDetailParam *param = [[IWDeletePressureDetailParam alloc] init];
        param.loginId = [IWUserTool user].loginId;
        param.companyId = @(IWCompanyId);
        param.bloodPressureId = self.pressureModel.pressureID;
        
        
        [IWMedicalArchivesTool deletePressureDetailWithParam:param success:^(IWBaseResult *result) {
            if (result.code == 0) {
                [MBProgressHUD showSuccess:@"删除成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:result.info];
            }
            
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD showError:@"请求失败"];
        }];

    }else{
        IWDeleteSugerDetailModel *param = [[IWDeleteSugerDetailModel alloc] init];
        param.loginId = [IWUserTool user].loginId;
        param.companyId = @(IWCompanyId);
        param.bloodSugarId  = self.sugerModel.sugerID;
        [IWMedicalArchivesTool deleteSugerDetailWithParam:param success:^(IWBaseResult *result) {
            if (result.code == 0) {
                [MBProgressHUD showSuccess:@"删除成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:result.info];

            }
        } failure:^(NSError *error) {
            [MBProgressHUD showError:@"请求失败"];
        }];
        
        
    }
}


- (void)BackClicked:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];

}



@end
