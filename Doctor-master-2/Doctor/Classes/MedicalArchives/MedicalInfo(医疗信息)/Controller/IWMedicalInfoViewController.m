//
//  IWMedicalInfoViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWMedicalInfoViewController.h"
#import "IWInfoTableViewCell.h"
#import "IWMedicalArchivesTool.h"
#import "IWGetMedicalHealthDetailParam.h"
#import "IWBloodTypeViewController.h"
#import "IWShengYuViewController.h"
#import "IWYanJiuViewController.h"
#import "IWGuoMinViewController.h"
#import "IWJiBingViewController.h"
#import "IWShouShuViewController.h"
#import "IWShuXueViewController.h"
#import "IWJiaZuViewController.h"
#import "IWMedicalArchivesTool.h"

@interface IWMedicalInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, weak) UITableView *myTableView;

@property (nonatomic, strong) NSArray *highArray;
@property (nonatomic, strong) NSArray *weightArray;
@property (nonatomic, strong) UIView *appView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;



@property (nonatomic, strong) IWUserHealthInfo *userHealthInfoModel;//用户信息model
@property (nonatomic, strong) NSArray *shengYuArray;
@property (nonatomic, strong) IWYanJiu *yanjiuModel;
@property (nonatomic, strong) IWGuoMin *guominModel;
@property (nonatomic, strong) IWBaoLu *baoluModel;
@property (nonatomic, strong) NSArray *jibingArray;
@property (nonatomic, strong) NSArray *shoushuArray;
@property (nonatomic, strong) NSArray *shuxueArray;
@property (nonatomic, strong) IWYiChuan *yichuanModel;
@property (nonatomic, strong) IWCanJi *canjiModel;


@property (nonatomic, strong) NSArray *jiazuFatherArray;
@property (nonatomic, strong) NSArray *jiazuMotherArray;
@property (nonatomic, strong) NSArray *jiazuBroAndSisArray;
@property (nonatomic, strong) NSArray *jiazuGrandPaAndMaArray;


@end

@implementation IWMedicalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //懒加载控件
    [self myTableView];
    
    [self loadData];
    
}

- (void)loadData
{
    
    IWGetMedicalHealthDetailParam *param = [[IWGetMedicalHealthDetailParam alloc] init];
    
    param.loginId = [IWUserTool user].loginId;
    param.memberId = self.memberId;
    param.companyId = @(IWCompanyId);
    
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWMedicalArchivesTool medicalHealthDetailWithParam:param success:^(IWGetMedicalHealthDetailResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            
            self.userHealthInfoModel = result.datas.userHealthInfo;
            self.shengYuArray = result.datas.shengyu;
            self.yanjiuModel = result.datas.yanjiu;
            self.guominModel = result.datas.guomin;
            self.baoluModel = result.datas.baolu;
            self.jibingArray = result.datas.jibing;
            self.shoushuArray = result.datas.shoushu;
            self.shuxueArray = result.datas.shuxue;
            self.jiazuFatherArray = result.datas.jiazuFather;
            self.jiazuMotherArray = result.datas.jiazuMother;
            self.jiazuBroAndSisArray = result.datas.jiazuBroAndSis;
            self.jiazuGrandPaAndMaArray = result.datas.jiazuGrandPaAndMa;
            self.yichuanModel = result.datas.yichuan;
            self.canjiModel = result.datas.canji;
            
            [self.myTableView reloadData];

        }else{
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (NSArray *)highArray{
    
    if (_highArray == nil) {
        NSMutableArray *highArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 30; i<230; i++) {
            NSString *str = [NSString stringWithFormat:@"%dcm",i];
            [highArray addObject:str];
            
            
        }
        _highArray = (NSArray *)highArray;
    }
    return _highArray;
}

- (NSArray *)weightArray{
    if (_weightArray == nil) {
        NSMutableArray *highArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 5; i<200; i++) {
            NSString *str = [NSString stringWithFormat:@"%dkg",i];
            [highArray addObject:str];
            
            
        }
        _weightArray = (NSArray *)highArray;
    }
    return _weightArray;
}

#pragma mark - 懒加载控件

- (UITableView *)myTableView
{
    if (_myTableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        [self.view insertSubview:tableView atIndex:1];
        _myTableView = tableView;
    }
    return _myTableView ;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 3;
    }
    
    if (section == 1) {//生育
        return self.shengYuArray.count + 1;
    }
    if (section == 2) {//烟酒
        if (self.yanjiuModel.smokeYear.length == 0 && self.yanjiuModel.smokeNum.length == 0 && self.yanjiuModel.drinkNum.length == 0 && self.yanjiuModel.drinkYear.length == 0 && self.yanjiuModel.wineType.length == 0) {
            return 1;
        }else{
            return 4;
        }
    }
    if (section == 3) {//过敏史
        return 1;
    }
    
    if (section == 4) {//暴露史
        return 1;
    }
    
    if (section == 5) {//疾病
        
        return self.jibingArray.count + self.shoushuArray.count + self.shuxueArray.count + 3;
        
        
    }
    if (section == 6) {//家族史
        
        return self.jiazuFatherArray.count + self.jiazuMotherArray.count + self.jiazuBroAndSisArray.count + self.jiazuGrandPaAndMaArray.count + 4;
    }
    
    if (section == 7) {//遗传病史
        return 1;
    }
    
    if (section == 8) {//残疾情况
        return 1;
    }

    if (section == 9) {//锻炼
        return 1;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    IWInfoTableViewCell *cell = [IWInfoTableViewCell normalTableViewCellWithTableView:tableView indexpath:indexPath];
    
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", [indexPath section], [indexPath row]];//以indexPath来唯一确定cell
    IWInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[IWInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.section == 0) {
        NSArray *titleArray = @[@"身高",@"体重",@"血型"];
        cell.titleLabel.text = titleArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.resultLabel.text = self.userHealthInfoModel.height;
        }else if (indexPath.row == 1){
            cell.resultLabel.text = self.userHealthInfoModel.weight;

        }else{
            NSString *kong = @"";
            NSString *str1 = [NSString stringWithFormat:@"%@",self.userHealthInfoModel.bloodType?self.userHealthInfoModel.bloodType:kong];
            NSString *str2 = [NSString stringWithFormat:@"%@",self.userHealthInfoModel.otherBloodType?self.userHealthInfoModel.otherBloodType:kong];
            cell.resultLabel.text = [NSString stringWithFormat:@"%@ %@",str1,str2];


        }
    }
    
    if (indexPath.section == 1) {
        
        if (self.shengYuArray.count > 0) {
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"生育史";
                cell.resultLabel.text = @"已育";

            }else{
                for (int i = 0; i<self.shengYuArray.count; i++) {
                    if (indexPath.row == i+1) {
                        NSString *sex = [self.shengYuArray[indexPath.row - 1] childGender];
                        NSString *time = [self.shengYuArray[indexPath.row-1] birthday];
                        NSString *type = [self.shengYuArray[indexPath.row - 1] birthType];
                        cell.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@",sex,time,type];
                        cell.editImageView.hidden = YES;
                        cell.titleLabel.text = @"";

                    }
                }
                
            }
        }else{
            cell.titleLabel.text = @"生育史";
            cell.resultLabel.text = @"未育";

        }
    }
    
    if (indexPath.section == 2) {//烟酒
        
        
        
        if (self.yanjiuModel.smokeYear.length == 0 && self.yanjiuModel.smokeNum.length == 0 && self.yanjiuModel.drinkNum.length == 0 && self.yanjiuModel.drinkYear.length == 0 && self.yanjiuModel.wineType.length == 0) {
            cell.titleLabel.text = @"烟酒史";
            cell.resultLabel.text =@"无";
            
        }else{
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"烟酒史";
                cell.resultLabel.text =@"";

            }else if (indexPath.row == 1){
                cell.titleLabel.text = @"吸烟";
                NSString *time;
                if (self.yanjiuModel.smokeYear) {
                    time= [NSString stringWithFormat:@"时长%@年",self.yanjiuModel.smokeYear];
                }else{
                    time = @"";
                }
                NSString *num ;
                if (self.yanjiuModel.smokeNum) {
                    num = [NSString stringWithFormat:@"数量%@支/天",self.yanjiuModel.smokeNum];
                }else{
                    num = @"";
                    
                }
                
                cell.resultLabel.text = [NSString stringWithFormat:@"%@  %@",time,num];
                cell.editImageView.hidden = YES;
                
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"饮酒";
                NSString *time;
                if (self.yanjiuModel.drinkYear) {
                    time =[NSString stringWithFormat:@"时长%@年",self.yanjiuModel.drinkYear];
                }else{
                    time = @"";
                }
                NSString *num;
                if (self.yanjiuModel.drinkNum) {
                    num =[NSString stringWithFormat:@"数量%@两/天",self.yanjiuModel.drinkNum];
                }else{
                    num = @"";
                }
                cell.resultLabel.text = [NSString stringWithFormat:@"%@  %@",time,num];
                cell.editImageView.hidden = YES;

                
            }else{
                cell.titleLabel.text = @"";
                if (self.yanjiuModel.wineType) {
                    cell.resultLabel.text =[NSString stringWithFormat:@"%@",self.yanjiuModel.wineType];
                    
                }else{
                    cell.resultLabel.text = @"";
                }
                cell.editImageView.hidden = YES;
            }

        }
        
    }
    
    if (indexPath.section == 3) {//过敏
        cell.titleLabel.text = @"过敏史";
        NSString *kong = @"";
        NSString *medicineName = [NSString stringWithFormat:@"%@",self.guominModel.medicineName?self.guominModel.medicineName:kong];
        NSString *otherMedicineName =  [NSString stringWithFormat:@"%@",self.guominModel.otherMedicineName?self.guominModel.otherMedicineName:kong];
        NSString *footName = [NSString stringWithFormat:@"%@",self.guominModel.footName?self.guominModel.footName:kong];
        NSString *otherFootName = [NSString stringWithFormat:@"%@",self.guominModel.otherFootName?self.guominModel.otherFootName:kong];
        NSString *otherName = [NSString stringWithFormat:@"%@",self.guominModel.otherName?self.guominModel.otherName:kong];
        NSString *otherOtherName = [NSString stringWithFormat:@"%@",self.guominModel.otherOtherName?self.guominModel.otherOtherName:kong];
        if (self.guominModel.medicineName.length == 0 && self.guominModel.otherMedicineName.length == 0 && self.guominModel.footName.length == 0 && self.guominModel.otherFootName.length == 0 && self.guominModel.otherName.length == 0 && self.guominModel.otherOtherName.length == 0) {
            cell.resultLabel.text = @"无";
        }else{
            NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",medicineName,otherMedicineName,footName,otherFootName,otherName,otherOtherName];
            cell.resultLabel.text = str;
        }
        cell.resultLabel.numberOfLines = 2;

    }
    
    if (indexPath.section == 4) {//暴露
        cell.titleLabel.text = @"暴露史";
        NSString *kong = @"";
        NSString *str1 = [NSString stringWithFormat:@"%@",self.baoluModel.exposeName?self.baoluModel.exposeName:kong];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.baoluModel.otherExposeName?self.baoluModel.otherExposeName:kong];
        if (str1.length == 0 && str2.length == 0 ) {
            cell.resultLabel.text = @"无";
        }else{
            NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
            cell.resultLabel.text = str;
        }

    }
    
    if (indexPath.section == 5) {//疾病既往史
        
        if (indexPath.row == 0) {
            if (self.jibingArray.count == 0) {
                cell.titleLabel.text = @"疾病";
                cell.resultLabel.text = @"无";


            }else{
                cell.titleLabel.text = @"疾病";
                cell.resultLabel.text = @"";


            }
        }else if (indexPath.row == self.jibingArray.count + 1){
            if (self.shoushuArray.count == 0) {
                cell.titleLabel.text = @"手术";
                cell.resultLabel.text = @"无";

            }else{
                cell.titleLabel.text = @"手术";
                cell.resultLabel.text = @"";


            }
        }else if (indexPath.row == self.jibingArray.count + self.shoushuArray.count + 2){
            if (self.shuxueArray.count == 0) {
                cell.titleLabel.text = @"输血";
                cell.resultLabel.text = @"无";


            }else{
                cell.titleLabel.text = @"输血";
                cell.resultLabel.text = @"";

            }
        }else{
            
            
            for (int i=0; i<self.jibingArray.count; i++) {
                if (indexPath.row == i+1) {
                    
                    cell.titleLabel.text = @"";
                    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",[self.jibingArray[i] bType],[self.jibingArray[i] otherType],[self.jibingArray[i] bTime]];
                    cell.resultLabel.text = str;
                    cell.editImageView.hidden = YES;
                    
                }
            }
            
      
            
            for (int i = 0; i<self.shoushuArray.count; i++) {
                if (indexPath.row == i+self.jibingArray.count+2) {
                    cell.titleLabel.text = @"";
                    NSString *str = [NSString stringWithFormat:@"%@ %@",[self.shoushuArray[i] bType],[self.shoushuArray[i] bTime]];
                    cell.resultLabel.text = str;
                    cell.editImageView.hidden = YES;


                }
            }
            
            for (int i = 0; i<self.shuxueArray.count; i++) {
                if (indexPath.row == i+self.jibingArray.count+self.shoushuArray.count+3) {
                    cell.titleLabel.text = @"";
                    NSString *str = [NSString stringWithFormat:@"%@ %@",[self.shuxueArray[i] bType],[self.shuxueArray[i] bTime]];
                    cell.resultLabel.text = str;
                    cell.editImageView.hidden = YES;



                }
            }
        }
        
        
        
    }
    
    

    if (indexPath.section == 6) {
        
        if (indexPath.row == 0) {
            if (self.jiazuGrandPaAndMaArray.count == 0) {
                cell.titleLabel.text = @"祖父母";
                cell.resultLabel.text = @"无";



            }else{
                cell.titleLabel.text = @"祖父母";
                cell.resultLabel.text = @"";



            }
        }else if (indexPath.row == 1+self.jiazuGrandPaAndMaArray.count)
        {
            if (self.jiazuFatherArray.count == 0) {
                cell.titleLabel.text = @"父亲";
                cell.resultLabel.text = @"无";


            }else{
                cell.titleLabel.text = @"父亲";
                cell.resultLabel.text = @"";


            }
        }else if (indexPath.row == 2+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count){
            if (self.jiazuMotherArray.count == 0) {
                cell.titleLabel.text = @"母亲";
                cell.resultLabel.text = @"无";

            }else{
                cell.titleLabel.text = @"母亲";
                cell.resultLabel.text = @"";


            }
        }else if (indexPath.row == 3+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count+self.jiazuMotherArray.count){
            if (self.jiazuBroAndSisArray.count == 0) {
                cell.titleLabel.text = @"兄弟姊妹";
                cell.resultLabel.text = @"无";

            }else{
                cell.titleLabel.text = @"兄弟姊妹";
                cell.resultLabel.text = @"";

            }

        }else{
            for (int i = 0; i<self.jiazuGrandPaAndMaArray.count; i++) {
                if (indexPath.row == i+1) {
                    NSString *tyep = [self.jiazuGrandPaAndMaArray[i] diseaseType];
                    NSString *otherType = [self.jiazuGrandPaAndMaArray[i] otherDiseaseType];
                    NSString *time1 = [self.jiazuGrandPaAndMaArray[i] occurTime];
                    NSString *time2 = [self.jiazuGrandPaAndMaArray[i] cureTime];
                    
                    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@",tyep,otherType,time1,time2];
                    cell.resultLabel.text = str ;
                    cell.editImageView.hidden = YES;
                    cell.titleLabel.text = @"";
                }
            }
            
            for (int i = 0; i<self.jiazuFatherArray.count; i++) {
                if (indexPath.row == i+self.jiazuGrandPaAndMaArray.count+2) {
                    NSString *tyep = [self.jiazuFatherArray[i] diseaseType];
                    NSString *otherType = [self.jiazuFatherArray[i] otherDiseaseType];
                    NSString *time1 = [self.jiazuFatherArray[i] occurTime];
                    NSString *time2 = [self.jiazuFatherArray[i] cureTime];
                    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@",tyep,otherType,time1,time2];
                    cell.resultLabel.text = str ;
                    cell.editImageView.hidden = YES;

                    cell.titleLabel.text = @"";

                }
            }
            
            
            for (int i = 0; i<self.jiazuMotherArray.count; i++) {
                if (indexPath.row == i+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count+3) {
                    NSString *tyep = [self.jiazuMotherArray[i] diseaseType];
                    NSString *otherType = [self.jiazuMotherArray[i] otherDiseaseType];
                    NSString *time1 = [self.jiazuMotherArray[i] occurTime];
                    NSString *time2 = [self.jiazuMotherArray[i] cureTime];
                    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@",tyep,otherType,time1,time2];
                    cell.resultLabel.text = str ;
                    cell.editImageView.hidden = YES;

                    cell.titleLabel.text = @"";

                }
            }
            
            for (int i=0; i<self.jiazuBroAndSisArray.count; i++) {
                if (indexPath.row == i+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count+self.jiazuMotherArray.count+4) {
                    NSString *tyep = [self.jiazuBroAndSisArray[i] diseaseType];
                    NSString *otherType = [self.jiazuGrandPaAndMaArray[i] otherDiseaseType];
                    NSString *time1 = [self.jiazuBroAndSisArray[i] occurTime];
                    NSString *time2 = [self.jiazuBroAndSisArray[i] cureTime];
                    NSString *str = [NSString stringWithFormat:@"%@ %@ %@ %@",tyep,otherType,time1,time2];
                    cell.resultLabel.text = str ;
                    cell.editImageView.hidden = YES;


                    cell.titleLabel.text = @"";


                }
            }
            
        }
        
        
    }
    
    if (indexPath.section == 7) {//遗传
        cell.titleLabel.text = @"遗传病史";
        NSString *kong = @"";
        NSString *str1 = [NSString stringWithFormat:@"%@",self.yichuanModel.geneticName?self.yichuanModel.geneticName:kong];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.yichuanModel.otherName?self.yichuanModel.otherName:kong];
        if (str1.length == 0 && str2.length == 0) {
            cell.resultLabel.text = @"无" ;
        }else{
            NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
            cell.resultLabel.text = str ;

        }

    }
    
    if (indexPath.section == 8) {//残疾
        cell.titleLabel.text = @"残疾情况";
        NSString *kong = @"";
        NSString *str1 = [NSString stringWithFormat:@"%@",self.canjiModel.disabilityName?self.canjiModel.disabilityName:kong];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.canjiModel.otherName?self.canjiModel.otherName:kong];
        if (str1.length == 0 && str2.length == 0) {
            cell.resultLabel.text = @"无";
        }else{
            NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
            cell.resultLabel.text = str;

        }

    }
    
    if (indexPath.section == 9) {//锻炼
        cell.titleLabel.text = @"锻炼情况";
        NSString *kong = @"";
        NSString *str1 = [NSString stringWithFormat:@"%@",self.userHealthInfoModel.exercise?self.userHealthInfoModel.exercise:kong];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.userHealthInfoModel.otherExercise?self.userHealthInfoModel.otherExercise:kong];
        if (str2.length == 0 && str1.length == 0 ) {
            cell.resultLabel.text = @"无";
        }else{
            NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
            cell.resultLabel.text = str;
        }

    }
    
    return cell;
}

- (NSString *)strTOstr:(NSString *)str{
    
    NSMutableString *mustr = [NSMutableString stringWithFormat:@"%@",str];
    
    [mustr insertString:@"-" atIndex:4];
    [mustr insertString:@"-" atIndex:7];
    NSString *resultStr = (NSString *)mustr;
    return resultStr;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray *array = self.highArray;
            
            [self showPickerViewwithtitleLabele:@"身高" anddataArray:array andIndexpath:indexPath];
        }else if (indexPath.row == 1)
        {
            NSArray *array = self.weightArray;
            [self showPickerViewwithtitleLabele:@"体重" anddataArray:array andIndexpath:indexPath];
            
        }else{
            IWBloodTypeViewController *vc =[[IWBloodTypeViewController alloc] init];
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_blood_title", nil);
            vc.memberID = self.memberId;
            vc.typeStr = @"BloodType";
            vc.selectedName = _userHealthInfoModel.bloodType;
            __weak typeof(_userHealthInfoModel)weakModel = _userHealthInfoModel;
            
            [vc setDrinkTypeSaveBlock:^(NSString *str1, NSString *str2) {
                weakModel.bloodType = str1;
                weakModel.otherBloodType = str2;
                [tableView reloadData];
            }];
            
            vc.textFieldtext = _userHealthInfoModel.otherBloodType;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section == 1) {//生育
        
        IWShengYuViewController *vc = [[IWShengYuViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_bear_title", nil);
        vc.memberID = self.memberId;
        vc.shengyuArray =  self.shengYuArray;
        [vc setSaveButtonBlock:^(NSArray *shengyuArray) {
            _shengYuArray = shengyuArray;
            [tableView reloadData];
        }];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 2) {//烟酒史
        IWYanJiuViewController *vc = [[IWYanJiuViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_tobacco_title", nil);
        vc.yanjiuModel = self.yanjiuModel;
        vc.memberID = self.memberId;
        __weak typeof(_yanjiuModel)weakModel = _yanjiuModel;
      
        [vc setSaveButtonBlock:^(NSString *s1, NSString *s2, NSString *s3, NSString *s4, NSString *s5) {
            weakModel.smokeYear = s1;
            weakModel.smokeNum = s2;
            weakModel.drinkYear = s3;
            weakModel.drinkNum =s4;
            weakModel.wineType = s5;

            [_myTableView reloadData];
            
        }];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section == 3) {//过敏种类
        IWGuoMinViewController *vc = [[IWGuoMinViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_allergy_title", nil);
        vc.guominModel = self.guominModel;
        vc.memberID = self.memberId;
        __weak typeof(_guominModel)weakModel = _guominModel;
        [vc setSaveButtonBlock:^(NSString *s1, NSString *s2, NSString *s3, NSString *s4, NSString *s5, NSString *s6) {
            weakModel.medicineName = s1;
            weakModel.otherMedicineName = s2;
            weakModel.footName = s3;
            weakModel.otherFootName = s4;
            weakModel.otherName = s5;
            weakModel.otherOtherName = s6;
                       
            [tableView reloadData];
            
        }];
        
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (indexPath.section == 4) {//暴露种类
        
        IWBloodTypeViewController *vc =[[IWBloodTypeViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_expose_title", nil);
        vc.typeStr = @"BaoLu";
        __weak typeof(_baoluModel)weakModel = _baoluModel;
        
        [vc setDrinkTypeSaveBlock:^(NSString *s1, NSString *s2) {
            weakModel.exposeName = s1;
            weakModel.otherExposeName = s2;
            [tableView reloadData];
        }];
        
        NSString *str = self.baoluModel.exposeName;
        NSArray *array = [str componentsSeparatedByString:@","];
        vc.selectArray = array;
        vc.memberID = self.memberId;
        vc.textFieldtext = self.baoluModel.otherExposeName;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.section == 5) {
    
        if (indexPath.row == 0) {//疾病
            IWJiBingViewController *vc = [[IWJiBingViewController alloc] init];
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_old_1", nil);
            vc.memberID =self.memberId;
            vc.jibingArray = self.jibingArray;
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _jibingArray = jibing;
                [tableView reloadData];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == self.jibingArray.count + 1){//手术列表
            
            IWShouShuViewController *vc = [[IWShouShuViewController alloc] init];
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_old2_type_title", nil);
            vc.shoushuArray = self.shoushuArray;
            vc.memberID =self.memberId;
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _shoushuArray = jibing;
                [tableView reloadData];
            }];

            [self.navigationController pushViewController:vc animated:YES];

            
        }else if (indexPath.row == self.jibingArray.count + self.shoushuArray.count + 2){//输血列表
            
            IWShuXueViewController *vc = [[IWShuXueViewController alloc] init];
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_old3_type_title", nil);
            vc.shuxueArray = self.shuxueArray;
            vc.memberID =self.memberId;
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _shuxueArray = jibing;
                [tableView reloadData];
            }];

            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
        }
    
    
    }

    
    if (indexPath.section == 6) {
        if (indexPath.row == 0) {//祖父母
            IWJiaZuViewController *vc = [[IWJiaZuViewController alloc] init];
            
            vc.memberID =self.memberId;
            vc.memberType = @"0";
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _jiazuGrandPaAndMaArray = jibing;
                [tableView reloadData];
            }];
            
            vc.jiazuArray = self.jiazuGrandPaAndMaArray;
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_family_1", nil);
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if (indexPath.row == 1+self.jiazuGrandPaAndMaArray.count)
        {//父亲
            IWJiaZuViewController *vc = [[IWJiaZuViewController alloc] init];
//            vc.typeStr = @"Father";
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_family_2", nil);
            vc.memberID =self.memberId;
            vc.memberType = @"1";
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _jiazuFatherArray = jibing;
                [tableView reloadData];
            }];

            vc.jiazuArray = self.jiazuFatherArray;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row == 2+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count){//母亲
            IWJiaZuViewController *vc = [[IWJiaZuViewController alloc] init];
//            vc.typeStr = @"Mother";
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_family_3", nil);
            vc.memberID =self.memberId;
            vc.memberType = @"2";
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _jiazuMotherArray = jibing;
                [tableView reloadData];
            }];

            vc.jiazuArray = self.jiazuMotherArray;
            [self.navigationController pushViewController:vc animated:YES];

        }else if (indexPath.row == 3+self.jiazuGrandPaAndMaArray.count+self.jiazuFatherArray.count+self.jiazuMotherArray.count){//兄弟姊妹
            IWJiaZuViewController *vc = [[IWJiaZuViewController alloc] init];
//            vc.typeStr = @"BroSir";
            vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_family_4", nil);
            vc.memberID =self.memberId;
            vc.memberType = @"3";
            [vc setSaveButtonBlock:^(NSArray *jibing) {
                _jiazuBroAndSisArray = jibing;
                [tableView reloadData];
            }];

            vc.jiazuArray = self.jiazuBroAndSisArray;
            [self.navigationController pushViewController:vc animated:YES];

        }else{
            
        }
        
        
        
    }
    
    if (indexPath.section == 7) {//遗传病史
        
        IWBloodTypeViewController *vc =[[IWBloodTypeViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_heredity_title", nil);
        vc.typeStr = @"YiChuan";
        __weak typeof(_yichuanModel)weakModel = _yichuanModel;
        
        [vc setDrinkTypeSaveBlock:^(NSString *s1, NSString *s2){
            weakModel.geneticName = s1;
            weakModel.otherName = s2;
            [tableView reloadData];
        }];

        NSString *str = self.yichuanModel.geneticName;
        NSArray *array = [str componentsSeparatedByString:@","];
        vc.selectArray = array;
        vc.memberID = self.memberId;
        vc.textFieldtext = self.yichuanModel.otherName;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    if (indexPath.section == 8) {//残疾情况
        
        IWBloodTypeViewController *vc =[[IWBloodTypeViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_disablity", nil);
        vc.typeStr = @"CanJi";
        __weak typeof(_canjiModel)weakModel = _canjiModel;
        
        [vc setDrinkTypeSaveBlock:^(NSString *s1, NSString *s2) {
            weakModel.disabilityName = s1;
            weakModel.otherName = s2;
            [tableView reloadData];
            
        }];
        NSString *str = self.canjiModel.disabilityName;
        NSArray *array = [str componentsSeparatedByString:@","];
        vc.memberID = self.memberId;
        vc.selectArray = array;
        vc.textFieldtext = self.canjiModel.otherName;
        [self.navigationController pushViewController:vc animated:YES];

    }
    
    if (indexPath.section == 9) {//锻炼情况
        
        IWBloodTypeViewController *vc =[[IWBloodTypeViewController alloc] init];
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_trainning", nil);
        vc.typeStr = @"DuanLian";
        __weak typeof(_userHealthInfoModel)weakModel = _userHealthInfoModel;        
        [vc setDrinkTypeSaveBlock:^(NSString *s1, NSString *s2) {

            weakModel.exercise = s1;
            weakModel.otherExercise = s2;
            [tableView reloadData];
        }];
        vc.memberID = self.memberId;
        vc.selectedName = _userHealthInfoModel.exercise;
        vc.textFieldtext = _userHealthInfoModel.otherExercise;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    
}
//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 5 || section == 6) {
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        backView.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 0, 200, 40);
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        [backView addSubview:view];
        if (section == 5) {
            label.text = @"疾病既往史";
        }else
        {
            label.text = @"家族史";
        }
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.frame = CGRectMake(10, CGRectGetMaxY(label.frame), self.view.frame.size.width-20, 0.5);
        [backView addSubview:lineView];
        
        return backView;
    }else{
        
        return nil;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 5 || section == 6) {
        return 40;
    }else
    {
        return 0.0001;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = NSLocalizedString(@"医疗信息",nil);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showPickerViewwithtitleLabele:(NSString *)title anddataArray:(NSArray *)dataArray andIndexpath:(NSIndexPath *)index;
{
    //背景View
    _appView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IWWIDTH, IWHEIGHT + 64)];
    _appView.userInteractionEnabled = YES;
    _appView.backgroundColor = [UIColor blackColor];
    _appView.alpha = 0.4;
    [[UIApplication sharedApplication].keyWindow addSubview:_appView];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.frame = CGRectMake(30, 150, IWWIDTH - 60, 300);
    [[UIApplication sharedApplication].keyWindow addSubview:_contentView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.frame = CGRectMake(10, 0, CGRectGetWidth(_contentView.frame) - 20, 50);
    titleLabel.textColor = [UIColor grayColor];
    [_contentView addSubview:titleLabel];
    
    
    //时间滚轴
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.frame = CGRectMake(60, 50, CGRectGetWidth(_contentView.frame)-120, 200);
    // 显示选中框
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.tag = index.row;
    if ([title isEqualToString:@"身高"]) {
        NSUInteger index = [self.highArray indexOfObject:_userHealthInfoModel.height];
        if(index != NSNotFound)
        {
            [_pickerView selectRow:index inComponent:0 animated:YES];
        } else {
            [_pickerView selectRow:[self.highArray indexOfObject:@"150cm"] inComponent:0 animated:YES];
        }
    }else{
        NSUInteger index = [self.weightArray indexOfObject:_userHealthInfoModel.weight];
        if(index != NSNotFound)
        {
            [_pickerView selectRow:index inComponent:0 animated:YES];
        } else {
            [_pickerView selectRow:[self.weightArray indexOfObject:@"50kg"] inComponent:0 animated:YES];
        }

    }
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.userInteractionEnabled = YES;
    [_contentView addSubview:_pickerView];
    
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 250 , CGRectGetWidth(_contentView.frame)/2, 50);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tag = 1;
    [cancelButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:cancelButton];
    
    
    UIButton *soButton = [UIButton buttonWithType:UIButtonTypeSystem];
    soButton.frame = CGRectMake(CGRectGetWidth(_contentView.frame)/2, 250,CGRectGetWidth(_contentView.frame)/2, 50);
    soButton.tag = 2;
    [soButton setTitle:@"保存" forState:UIControlStateNormal];
    [soButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    soButton.backgroundColor = [UIColor whiteColor];
    [soButton addTarget:self action:@selector(saveButton) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:soButton];
    
    
}

- (void)cancelAction
{
    [self.appView removeFromSuperview];
    [self.contentView removeFromSuperview];
}

- (void)saveButton
{
    [self.appView removeFromSuperview];
    [self.contentView removeFromSuperview];
    

    if (self.pickerView.tag == 0) {
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        NSString *str = self.highArray[row];
        _userHealthInfoModel.height = str ;
        [self.myTableView reloadData];
        
        //保存身高
    
        IWAddHeightParam  * param = [[IWAddHeightParam alloc] init];
        param.loginId = self.memberId;
        param.companyId = @(IWCompanyId);
        param.height = str;
        
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalHeightWithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
            }else{

                [MBProgressHUD showSuccess:result.info];
            }
            
        } failure:^(NSError *error) {
        
            [MBProgressHUD hideHUD];
        }];
        
    }else{
        NSInteger row = [self.pickerView selectedRowInComponent:0];
        NSString *str = self.weightArray[row];
        _userHealthInfoModel.weight = str ;
        [self.myTableView reloadData];
        
        IWAddWeightParam *param = [[IWAddWeightParam alloc] init];
        param.loginId = self.memberId;
        param.companyId = @(IWCompanyId);
        param.weight = str ;
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalWeightWithParam:param success:^(IWBaseResult *result) {
        
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
            }else{
                
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
        
        
    }
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView.tag == 0) {
        return self.highArray.count;
    }else{
        return self.weightArray.count;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    UILabel *myView = nil;
    
    if (pickerView.tag == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 50)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [self.highArray objectAtIndex:row];
        myView.textColor = IWGlobalColor;
        myView.font = [UIFont systemFontOfSize:16];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
//        UIView *topLineview = [[UIView alloc] init];
//        topLineview.backgroundColor = [UIColor lightGrayColor];
//        topLineview.frame = CGRectMake(CGRectGetMidX(myView.frame)-100, 0, 200, 0.5);
//        [myView addSubview:topLineview];
        
        
        
    }else{
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [self.weightArray objectAtIndex:row];
        
        myView.textColor = IWGlobalColor;
        myView.font = [UIFont systemFontOfSize:16];
        myView.backgroundColor = [UIColor clearColor];
    }

    
    
    return myView;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    return 120;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 50;
    
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
