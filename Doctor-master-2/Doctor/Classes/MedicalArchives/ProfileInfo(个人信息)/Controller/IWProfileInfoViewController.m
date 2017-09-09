//
//  IWProfileInfoViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileInfoViewController.h"
#import "IWProfileArowTableViewCell.h"
#import "IWProfileTextFieldTableViewCell.h"
#import "IWProfileSecondViewController.h"
#import "IWProfileInfoModel.h"
#import "IWProfileSFViewController.h"
#import "IWMedicalArchivesTool.h"
#import "IWAddUserInfoParam.h"
#import "TPKeyboardAvoidingTableView.h"

#define PickViewWidth (CGRectGetWidth(_contentView.frame)-80)/3

@interface IWProfileInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

{
    NSData *imageData;
    UIButton *iconButton;
    NSMutableArray *dataSource;
}
@property (nonatomic, strong) IWProfileInfoModel *model;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *profileTableView;



@property (nonatomic, weak) UIDatePicker *beginDatePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;
@property (nonatomic, copy) NSString *timetext;


@property (nonatomic, strong) UIView *appView;//时间选择器的背景view
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *appView1;//
@property (nonatomic, strong) UIView *contentView1;

@property (nonatomic, strong) UIPickerView *pickerViewyear;
@property (nonatomic, strong) UIPickerView *pickerViewmonth;
@property (nonatomic, strong) UIPickerView *pickerViewday;

@property (nonatomic, strong) NSArray *timeArray;

@property (nonatomic, strong) NSMutableArray *siTypes;

@end

@implementation IWProfileInfoViewController

- (NSMutableArray *)siTypes {
    if (_siTypes == nil) {
        _siTypes = [NSMutableArray array];
        [_siTypes addObject:@"无"];
        [_siTypes addObject:@"有"];
        [_siTypes addObject:@"取消"];
    }
    return _siTypes;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.isFromMine) {
        [self loadData];
    }
}


-(void)setModelId:(NSString *)modelId{
    _modelId = modelId;
    IWProfileInfoModel *model = [[IWProfileInfoModel alloc ] init];
    NSString *str = [NSString stringWithFormat:@"%@",modelId];
    if ([str isEqualToString:@"kong"]) {
        model.userName = @"";
        model.relationship = @"2";
        model.gender2show = @"";
        model.birthday = @"";
        model.communityName = @"";
        model.siPlace = @"";
        model.siPlace2show = @"";
        model.occupation2show = @"";
        model.maritalStatus2show = @"";
        model.education2show = @"";
        model.siStatus = @"0";
        model.siCode = @"";
        model.cellphone = @"";
        model.mail = @"";
        model.userCard = @"";
      
        self.model = model;
        
        [self.profileTableView reloadData];
        
    }else{
        [self loadData];
    }
}

- (NSArray *)timeArray{
    if (_timeArray == nil) {
        NSMutableArray *a1 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 1900; i<2017; i++) {
            [a1 addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        NSMutableArray *a2 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 1; i<13; i++) {
            [a2 addObject:[NSString stringWithFormat:@"%.2d",i]];
        }

        NSMutableArray *a3 = [NSMutableArray arrayWithCapacity:0];
        for (int i = 1; i<32; i++) {
            [a3 addObject:[NSString stringWithFormat:@"%.2d",i]];
        }
        NSArray *array = @[a1,a2,a3];
        _timeArray = array;
    }
    return _timeArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏
    [self setupNavgation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCommunityName:) name:@"changeCommunityName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cahngeCityName:) name:@"changecityName" object:nil];
}

- (void)changeCommunityName:(NSNotification *)info{
    _model.communityName = info.userInfo[@"communituName"];
    _model.communityId = info.userInfo[@"communituID"];
    [_profileTableView reloadData];
}

- (void)cahngeCityName:(NSNotification *)noti
{
    _model.siPlace =noti.userInfo[@"regionCode"];
    _model.siPlace2show =noti.userInfo[@"regionName"];
    [self.profileTableView reloadData];
}

- (void)setupNavgation
{
    if (self.isFromMine) {
        self.navigationItem.title = NSLocalizedString(@"mine_user_title", nil);
    } else {
        self.navigationItem.title = NSLocalizedString(@"inquiry_user_info_title", nil);
        if ([self.relationship intValue] !=0) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(cancleclicked)];

        }
    }
}

- (void)cancleclicked
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除健康档案" message:@"将删除该人的个人信息以及医疗报告和医疗信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

#pragma mark - 弹框的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex < 2) {
            _model.siStatus = [NSString stringWithFormat:@"%d", buttonIndex];
            [_profileTableView reloadData];
        }
    } else {
        if (buttonIndex == 1) {
            NSLog(@"确认");

            IWDeleteInquiryMemberParam *param = [[IWDeleteInquiryMemberParam alloc] init];
            param.loginId = [IWUserTool user].loginId;
            param.companyId = @(IWCompanyId);
            param.memberId = self.modelId;
            
            [IWMedicalArchivesTool deleteMedicalMemberWithParam:param success:^(IWBaseResult *result) {
                
            } failure:^(NSError *error) {
                
            }];
            
            
        }else
        {
            NSLog(@"取消");
        }
    }
    
}

#pragma mark - 数据请求
- (void)loadData
{
    NSString *cellphone = [IWUserTool user].cellphone;
    NSNumber *companyId = @(IWCompanyId);
    NSString *loginID = [NSString stringWithFormat:@"%@",[IWUserTool user].loginId];
    NSString *memberId = self.modelId;
    NSString *pwd = [IWUserTool user].pwd;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
    [params setValue:cellphone forKey:@"cellphone"];
    [params setValue:companyId forKey:@"companyId"];
    [params setValue:loginID forKey:@"loginId"];
    [params setValue:memberId forKey:@"memberId"];
    [params setValue:pwd forKey:@"pwd"];
    
    
    [IWHttpTool postWithURL:SERVER_GET_LOGIN_INFO_URL params:params success:^(id json) {
        
        if ([json[@"code"] intValue] == 0) {
            
            NSDictionary *tempDic = json[@"datas"];
            IWProfileInfoModel *model = [[IWProfileInfoModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            self.model = model;
            [self.profileTableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 懒加载

-(TPKeyboardAvoidingTableView *)profileTableView{
    if (_profileTableView == nil) {
        
        CGFloat height = self.view.frame.size.height;
        NSString *modelId = [NSString stringWithFormat:@"%@", self.modelId];
        if ([modelId isEqualToString:@"kong"]) { // 不知道什么原因导致的，暂时这样解决吧
            height = height - 64;
        }
        
        TPKeyboardAvoidingTableView * tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height) style:UITableViewStyleGrouped];
        
        
        tableView.backgroundColor=IWTableViewBgColor;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.scrollEnabled=YES;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.dataSource=self;
        tableView.delegate=self;
        [self.view addSubview:tableView];
        _profileTableView = tableView;
    }
    return _profileTableView;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if ([_model.siStatus intValue] == 1) {
        
        if (section == 0) {
            if (self.isFromMine) {
                return 5;
            }else{
                return 6;

            }
        }else{
            return 4;
        }
        
    }else{
        if (section == 0) {
            
            if (self.isFromMine) {
                return 5;
            }else{
                return 6;
                
            }
        }else if (section == 1){
            return 4;
        }
        else
        {
            return 3;
        }
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NSString *timeStr = [self timeStrTOdateTOtimeStr:_model.birthday];

        NSArray *titleArray;
        NSArray *resultArray;
        if (self.isFromMine) {//不显示  与本账户关系
            titleArray = @[@"姓名",@"性别",@"出生日期",@"社区",@"所属区域",];
            resultArray = @[_model.userName,_model.gender2show,timeStr,_model.communityName,_model.siPlace2show];
            
            if (indexPath.row == 0) {
                IWProfileTextFieldTableViewCell *cell = [IWProfileTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.newsTextField.placeholder = @"请填写真实姓名";
                cell.newsTextField.text = resultArray[indexPath.row];
                cell.newsTextField.delegate = self;
                cell.newsTextField.tag = 100001;
                [cell.newsTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
                
                return cell;
                
            }else
            {
                IWProfileArowTableViewCell *cell  = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.resultLabel.text = resultArray[indexPath.row];
                return cell;
            }

            
        }else{//显示  与本账户关系
            titleArray = @[@"姓名",@"与本账户关系",@"性别",@"出生日期",@"社区",@"所属区域",];
            resultArray = @[_model.userName,_model.relationship,_model.gender2show,timeStr,_model.communityName,_model.siPlace2show];
            
            if (indexPath.row == 0) {
                IWProfileTextFieldTableViewCell *cell = [IWProfileTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.newsTextField.placeholder = @"请填写真实姓名";
                cell.newsTextField.text = resultArray[indexPath.row];
                cell.newsTextField.delegate = self;
                cell.newsTextField.tag = 100001;
                [cell.newsTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
                
                return cell;
                
            }else if (indexPath.row == 1){
                
                IWProfileArowTableViewCell *cell  = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                if ([resultArray[indexPath.row] isEqualToString:@"0"]) {
                    cell.resultLabel.text = @"本人";
                }else if ([resultArray[indexPath.row] isEqualToString:@"1"]){
                    cell.resultLabel.text = @"家人";
                }else{
                    cell.resultLabel.text = @"其他";
                }
                return cell;
                
            }else
            {
                IWProfileArowTableViewCell *cell  = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                
                cell.resultLabel.text = resultArray[indexPath.row];
                return cell;
            }

            
        }
    }
    
    if (indexPath.section == 1) {
        NSArray *titleArray = @[NSLocalizedString(@"inquiry_user_info_occupation", nil),
                                NSLocalizedString(@"inquiry_user_info_userCard", nil),
                                NSLocalizedString(@"inquiry_user_info_maritalStatus", nil),
                                NSLocalizedString(@"inquiry_user_info_education", nil)];
        
        NSArray *resultArray;
        resultArray = @[_model.occupation2show,_model.userCard,_model.maritalStatus2show,_model.education2show];
        
        if (indexPath.row == 1) {
            IWProfileTextFieldTableViewCell *cell = [IWProfileTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
            cell.titleLabel.text = titleArray[indexPath.row];
            cell.newsTextField.placeholder = @"请填写身份证号";
            cell.newsTextField.tag = 100002;
            cell.newsTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.newsTextField.text = resultArray[indexPath.row];
            [cell.newsTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];

            return cell;
        }else
        {
            IWProfileArowTableViewCell *cell  = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
            cell.titleLabel.text = titleArray[indexPath.row];
            
            cell.resultLabel.text = resultArray[indexPath.row];
            return cell;
            
        }
    }
    
    if (indexPath.section == 2) {
        if ([_model.siStatus intValue] == 0) {//无社保
            NSArray *titleArray = @[NSLocalizedString(@"inquiry_user_info_siStatus", nil),NSLocalizedString(@"inquiry_user_info_cellphone", nil),NSLocalizedString(@"inquiry_user_info_mail", nil)];
            NSArray *resultArray;
            resultArray = @[@"无",_model.cellphone,_model.mail];
            if (indexPath.row == 0) {
                IWProfileArowTableViewCell *cell = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.resultLabel.text = resultArray[indexPath.row];
                
                return cell;
            }else
            {
                IWProfileTextFieldTableViewCell *cell  = [IWProfileTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                
                cell.newsTextField.text = resultArray[indexPath.row];
                if (indexPath.row == 1) {
                    cell.newsTextField.tag = 100004;
                    cell.newsTextField.keyboardType = UIKeyboardTypeNumberPad;

                }
                if (indexPath.row == 2) {
                    cell.newsTextField.tag = 100005;
                    cell.newsTextField.keyboardType = UIKeyboardTypeEmailAddress;
                }
                
                return cell;
                
            }
            
        }else{
            NSArray *titleArray = @[NSLocalizedString(@"inquiry_user_info_siStatus", nil),NSLocalizedString(@"inquiry_user_info_siCode", nil),NSLocalizedString(@"inquiry_user_info_cellphone", nil),NSLocalizedString(@"inquiry_user_info_mail", nil)];
            NSArray *resultArray;
            resultArray = @[@"有",_model.siCode,_model.cellphone,_model.mail];
            if (indexPath.row == 0) {
                IWProfileArowTableViewCell *cell = [IWProfileArowTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.resultLabel.text = resultArray[indexPath.row];
                
                return cell;
            }else
            {
                IWProfileTextFieldTableViewCell *cell  = [IWProfileTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
                cell.titleLabel.text = titleArray[indexPath.row];
                cell.newsTextField.text = resultArray[indexPath.row];
                if (indexPath.row == 1) {
                    cell.newsTextField.tag = 100003;
                    cell.newsTextField.keyboardType = UIKeyboardTypeNumberPad;

                }
                if (indexPath.row == 2) {
                    cell.newsTextField.tag = 100004;
                    cell.newsTextField.keyboardType = UIKeyboardTypeNumberPad;
                }
                if (indexPath.row == 3) {
                    cell.newsTextField.tag = 1000005;
                    cell.newsTextField.keyboardType = UIKeyboardTypeEmailAddress;

                }
                
                [cell.newsTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];

                return cell;
                
            }
        }
        
        
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *bgView =[[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
        bgView.backgroundColor = [UIColor whiteColor];
        
        
        
        iconButton = [[UIButton alloc] init];
        iconButton.frame = CGRectMake(self.view.frame.size.width / 2 - 30, 10, 60, 60);
        
        iconButton.layer.masksToBounds = YES;
        iconButton.layer.cornerRadius = 30;
        [iconButton addTarget:self action:@selector(iconButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (_model.photo) {
            
            UIImageView *imageView = [[UIImageView alloc]init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_model.photo] placeholderImage:[UIImage imageNamed:@"90boy"]];
            UIImage *image = imageView.image;
            [iconButton setImage:image forState:UIControlStateNormal];
        }else{
            [iconButton setImage:[UIImage imageNamed:@"90boy"] forState:UIControlStateNormal];
            
        }
        
        
        [bgView addSubview:iconButton];
        
        
        return bgView;
    }else{
        return nil;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 80;
    }else
    {
        return 0.0001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        UIView *bgview = [[UIView alloc] init];
        bgview.backgroundColor = [UIColor whiteColor];
        bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
        
        UIButton *savebutton = [[UIButton alloc] init];
        savebutton.frame = CGRectMake(10, 10, self.view.frame.size.width-20, 36);
        savebutton.backgroundColor = [UIColor clearColor];
        savebutton.titleLabel.font = [UIFont systemFontOfSize:15];
        [savebutton setTitle:@"保存" forState:UIControlStateNormal];
        [savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [savebutton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        savebutton.layer.masksToBounds = YES;
        savebutton.layer.cornerRadius = 3;
        NSArray *arrat = @[@"t_btn_normal",@"t_btn_press"];
        for (int i = 0; i<2; i++) {
            // 加载图片
            UIImage *image = [UIImage imageNamed:arrat[i]];
            
            // 设置端盖的值
            CGFloat top = image.size.height * 0.5;
            CGFloat left = image.size.width * 0.5;
            CGFloat bottom = image.size.height * 0.5;
            CGFloat right = image.size.width * 0.5;
            
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
            
            // 拉伸图片
            UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
            
            if (i == 0) {
                [savebutton setBackgroundImage:newImage forState:UIControlStateNormal];
                
            }else{
                [savebutton setBackgroundImage:newImage forState:UIControlStateHighlighted];
                
            }
        }
        
        
        savebutton.contentMode = UIViewContentModeScaleAspectFit;
        [bgview addSubview:savebutton];
        return bgview;
    }else
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = IWTableViewBgColor;
        view.bounds = CGRectMake(0, 0, self.view.frame.size.width, 10);
        return view;
        
    }
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 70;
    }else
    {
        return 10;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//第一组

        if (self.isFromMine ) {//不显示 relationship cell
            NSArray *titleArray = @[NSLocalizedString(@"inquiry_add_name", nil),
                                    NSLocalizedString(@"inquiry_user_info_gender",nil),
                                    NSLocalizedString(@"inquiry_add_age", nil),
                                    NSLocalizedString(@"inquiry_user_info_community", nil),
                                    NSLocalizedString(@"inquiry_user_info_siPlace", nil),];
            
            if (indexPath.row == 1) {
                
                IWProfileSecondViewController *vc = [[IWProfileSecondViewController alloc] init];
                vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
                if ([_model.gender2show isEqualToString:@"男"]) {
                    vc.selectName = NSLocalizedString(@"activity_medical_bear_sex_1", nil);
                    
                }else if ([_model.gender2show isEqualToString:@"女"]){
                    vc.selectName = NSLocalizedString(@"activity_medical_bear_sex_2", nil);
                }else{
                    vc.selectName = NSLocalizedString(@"sex_other", nil);
                }
                
                __weak typeof(_model)wm = _model;
                [vc setSaveButtonBlock:^(NSString *text, NSString *numid) {
                    wm.gender2show = text;
                    if ([text isEqualToString:@"男"]) {
                        wm.gender = @"1";
                    }else if ([text isEqualToString:@"女"]){
                        wm.gender = @"2";
                    }else{
                        wm.gender = @"3";
                    }
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
                vc.index = indexPath;
                vc.isFromMine = self.isFromMine;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            if (indexPath.row == 2)//row 3
            {
                [self showPickerViewwithtitleLabele:@"出生日期" anddataArray:nil andIndexpath:indexPath];
            }
            
            if (indexPath.row == 3 || indexPath.row == 4){//row 社区 所属区域
                IWProfileSFViewController *vc = [[IWProfileSFViewController alloc] init];
                vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
                vc.index = indexPath;
                vc.isFromMine = self.isFromMine;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{//显示 relationship  cell
            NSArray *titleArray = @[NSLocalizedString(@"inquiry_add_name", nil),
                                    NSLocalizedString(@"inquiry_user_info_relative", nil),
                                    NSLocalizedString(@"inquiry_user_info_gender",nil),
                                    NSLocalizedString(@"inquiry_add_age", nil),
                                    NSLocalizedString(@"inquiry_user_info_community", nil),
                                    NSLocalizedString(@"inquiry_user_info_siPlace", nil),];
            if ([self.relationship intValue] != 0) {
                if (indexPath.row == 1) {
                    IWProfileSecondViewController *vc = [[IWProfileSecondViewController alloc] init];
                    vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
                    
                    if ([_model.relationship isEqualToString:@"0"]) {
                        vc.selectName = NSLocalizedString(@"medical_archives_me", nil);
                    }else if ([_model.relationship isEqualToString:@"1"]){
                        vc.selectName = NSLocalizedString(@"medical_archives_family", nil);
                    }else if ([_model.relationship isEqualToString:@"2"]){
                        vc.selectName = NSLocalizedString(@"medical_archives_other", nil);
                    }
                    
                    __weak typeof(_model)wm = _model;
                    [vc setSaveButtonBlock:^(NSString *text, NSString *numid) {
                        if ([text
                             isEqualToString:NSLocalizedString(@"medical_archives_other", nil)]) {
                            wm.relationship = @"2";
                        }
                        
                        if ([text isEqualToString:NSLocalizedString(@"medical_archives_family", nil)]) {
                            wm.relationship = @"1";
                        }
                        
                        if ([text isEqualToString:NSLocalizedString(@"medical_archives_me", nil)]) {
                            wm.relationship = @"0";
                        }
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    vc.index = indexPath;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
            if (indexPath.row == 2) {
                
                IWProfileSecondViewController *vc = [[IWProfileSecondViewController alloc] init];
                vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
                if ([_model.gender2show isEqualToString:@"男"]) {
                    vc.selectName = NSLocalizedString(@"activity_medical_bear_sex_1", nil);
                    
                }else if ([_model.gender2show isEqualToString:@"女"]){
                    vc.selectName = NSLocalizedString(@"activity_medical_bear_sex_2", nil);
                }else{
                    vc.selectName = NSLocalizedString(@"sex_other", nil);
                }
                
                __weak typeof(_model)wm = _model;
                [vc setSaveButtonBlock:^(NSString *text, NSString *numid) {
                    wm.gender2show = text;
                    if ([text isEqualToString:@"男"]) {
                        wm.gender = @"1";
                    }else if ([text isEqualToString:@"女"]){
                        wm.gender = @"2";
                    }else{
                        wm.gender = @"3";
                    }
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                }];
                vc.index = indexPath;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            if (indexPath.row == 3)//row 3
            {
                [self showPickerViewwithtitleLabele:@"出生日期" anddataArray:nil andIndexpath:indexPath];
            }
            
            if (indexPath.row == 4 || indexPath.row == 5){//row 社区 所属区域
                IWProfileSFViewController *vc = [[IWProfileSFViewController alloc] init];
                vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
                vc.index = indexPath;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
        
    }
    
    if (indexPath.section == 1) {
        NSArray *titleArray = @[NSLocalizedString(@"inquiry_user_info_occupation", nil),
                                NSLocalizedString(@"inquiry_user_info_userCard", nil),
                                NSLocalizedString(@"inquiry_user_info_maritalStatus", nil),
                                NSLocalizedString(@"inquiry_user_info_education",nil)];
        
        if (indexPath.row != 1) {//职业 婚姻 文化程度
            
            IWProfileSecondViewController *vc = [[IWProfileSecondViewController alloc] init];
            vc.title = NSLocalizedString(titleArray[indexPath.row], nil);
            vc.index = indexPath;
            
            if (indexPath.row == 0) {
                vc.selectName = _model.occupation2show;
            }else if (indexPath.row == 2)
            {
                vc.selectName = _model.maritalStatus2show;
            }else{
                vc.selectName = _model.education2show;
            }
            
            __weak typeof(_model)wm = _model;
            [vc setSaveButtonBlock:^(NSString *text, NSString *numid) {
                if (indexPath.row == 0) {
                    wm.occupation2show = text;
                    wm.occupation = numid;
                }else if (indexPath.row == 2)
                {
                    wm.maritalStatus2show = text;
                    wm.maritalStatus = numid;
                }else{
                    wm.education2show = text;
                    wm.education = numid;
                }
                
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
    
    if (indexPath.section == 2) {
        NSArray *titleArray = @[NSLocalizedString(@"inquiry_user_info_siStatus", nil),NSLocalizedString(@"inquiry_user_info_siCode", nil),NSLocalizedString(@"inquiry_user_info_cellphone", nil),NSLocalizedString(@"inquiry_user_info_mail", nil)];
        
        if (indexPath.row == 0) {
            [self showSiStatus];
        }
    }
}
- (void)showSiStatus{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:self.siTypes[0], self.siTypes[1], self.siTypes[2], nil];
    alertView.tag = 100;
    [alertView show];
    
//    //背景View
//    _appView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IWWIDTH, IWHEIGHT + 64)];
//    _appView1.userInteractionEnabled = YES;
//    _appView1.backgroundColor = [UIColor blackColor];
//    _appView1.alpha = 0.4;
//    [[UIApplication sharedApplication].keyWindow addSubview:_appView1];
//    
//    _contentView1 = [[UIView alloc] init];
//    _contentView1.backgroundColor = [UIColor whiteColor];
//    _contentView1.size = CGSizeMake(IWWIDTH - 60, 80);
//    _contentView1.frame = CGRectMake(30, IWHEIGHT * 0.5 + 80, IWWIDTH - 60, 120);
//    [[UIApplication sharedApplication].keyWindow addSubview:_contentView1];
//    
//    NSArray *array = @[@"有",@"无"];
//    for (int i = 0; i<2; i++) {
//        UIButton *button = [[UIButton alloc] init];
//        button.frame = CGRectMake(0, 60*i, _contentView1.frame.size.width, 60);
//        [button setTitle:array[i] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:16];
//        button.layer.borderWidth = 0.5;
//        button.layer.borderColor = [UIColor grayColor].CGColor;
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, IWValue(-400), 0, 0)];
//        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(sistatusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = i+1000;
//        [_contentView1 addSubview:button];
//    }

}

- (void)sistatusButtonClicked:(UIButton *)btn{
    
    if (btn.tag==1000) {
        [self.contentView1 removeFromSuperview];
        [self.appView1 removeFromSuperview];

        _model.siStatus = @"1";
        [_profileTableView reloadData];
    
    }else{
        [_contentView1 removeFromSuperview];
        [_appView1 removeFromSuperview];

        _model.siStatus = @"0";
        [_profileTableView reloadData];

    }
    
    
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
    
    
    NSString *timeStr = self.model.birthday;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    //先设置给定的字符串是什么格式的例如yyyyMMddHHmmss
    [dateFormat1 setLocale:[NSLocale currentLocale]];
    [dateFormat1 setDateFormat:@"yyyyMMdd"];
    [dateFormat1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDate *date1 = [dateFormat1 dateFromString:timeStr];
    //将日期转为指定格式
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc]init];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    [dateFormat2 setLocale:[NSLocale currentLocale]];
    //将NSDate格式时间转成什么格式的字符串例如转成M-d
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    [dateFormat2 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *resultTimeStr = [dateFormat2 stringFromDate:date1];

    NSArray *array = [resultTimeStr componentsSeparatedByString:@"-"];
    
    //时间滚轴
    _pickerViewyear = [[UIPickerView alloc] init];
    _pickerViewyear.frame = CGRectMake(20, 50, PickViewWidth, 200);
    // 显示选中框
    _pickerViewyear.dataSource = self;
    _pickerViewyear.delegate = self;
    _pickerViewyear.tag = 101;
    
    NSUInteger year = [self.timeArray[0] indexOfObject:array[0]];
    if(year != NSNotFound)
    {
        [_pickerViewyear selectRow:year inComponent:0 animated:YES];
    }

    [_contentView addSubview:_pickerViewyear];
    
    //时间滚轴
    _pickerViewmonth = [[UIPickerView alloc] init];
    _pickerViewmonth.frame = CGRectMake(PickViewWidth + 40, 50,PickViewWidth, 200);
    _pickerViewmonth.dataSource = self;
    _pickerViewmonth.delegate = self;
    _pickerViewmonth.tag = 102;
    NSUInteger month = [self.timeArray[1] indexOfObject:array[1]];
    if(month != NSNotFound)
    {
        [_pickerViewmonth selectRow:month inComponent:0 animated:YES];
    }

    [_contentView addSubview:_pickerViewmonth];

    //时间滚轴
    _pickerViewday = [[UIPickerView alloc] init];
    _pickerViewday.frame = CGRectMake((PickViewWidth + 20)*2 + 20, 50, PickViewWidth, 200);
    // 显示选中框
//    _pickerViewday.showsSelectionIndicator=YES;
    _pickerViewday.dataSource = self;
    _pickerViewday.delegate = self;
    _pickerViewday.tag = 103;
    _pickerViewday.backgroundColor = [UIColor whiteColor];
    _pickerViewday.userInteractionEnabled = YES;
    NSUInteger day = [self.timeArray[2] indexOfObject:array[2]];
    if(day != NSNotFound)
    {
        [_pickerViewday selectRow:day inComponent:0 animated:YES];
    }

    [_contentView addSubview:_pickerViewday];

    
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
    
    NSUInteger yearrow = [self.pickerViewyear selectedRowInComponent:0];
    NSString *yearStr = self.timeArray[0][yearrow];
    
    NSUInteger monthrow = [self.pickerViewmonth selectedRowInComponent:0];
    NSString *monthStr = self.timeArray[1][monthrow];
    
    NSUInteger dayRow = [self.pickerViewday selectedRowInComponent:0];
    NSString *dayStr = self.timeArray[2][dayRow];
    
    self.model.birthday = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
    
    [_profileTableView reloadData];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 101) {
        NSArray *array = self.timeArray[0];
        return array.count;
    }else if (pickerView.tag == 102){
        NSArray *array = self.timeArray[1];
        return array.count;
    }else{
        NSArray *array = self.timeArray[2];
        return array.count;

    }
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (pickerView.tag == 101) {
        
        NSArray *array = self.timeArray[0];
        
        UILabel *myView = [[UILabel alloc] init];
        myView.frame = CGRectMake(0, 0, 100, 40);
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [array objectAtIndex:row];
        myView.textColor = IWGlobalColor;
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
        
    }else if (pickerView.tag == 102){
        NSArray *array = self.timeArray[1];
        
        UILabel *myView = [[UILabel alloc] init];
        myView.frame = CGRectMake(0, 0, 100, 50);
        
        myView.textAlignment = NSTextAlignmentCenter;
        myView.textColor = IWGlobalColor;

        myView.text = [array objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
    }else{
        NSArray *array = self.timeArray[2];
        
        UILabel *myView = [[UILabel alloc] init];
        myView.frame = CGRectMake(0, 0, 100, 50);
        myView.textColor = IWBlueColor;

        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.text = [array objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
        
        myView.backgroundColor = [UIColor clearColor];
        
        return myView;
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    return PickViewWidth;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 50;
    
}

#pragma mark - saveButton的点击方法
- (void)iconButtonClicked:(UIButton *)button
{
    NSLog(@"iconButtonClicked");
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
    [sheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        //拍照
        [self takePhoto];
        
    }
    if(buttonIndex == 1){
        
        //从手机相册选择
        [self LocalPhoto];
    }
}

//拍照
- (void)takePhoto{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:NO completion:nil];
    }else {
        NSLog(@"该设备无摄像头");
    }
}

//从手机相册选择
- (void)LocalPhoto{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:NO completion:nil];
    
}

#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        //图片显示在界面上
        [iconButton setImage:image forState:UIControlStateNormal];
        
        imageData = UIImageJPEGRepresentation(image, 0.5);
        
    }
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //保存头像
    //    [self saveUsersIcon];
}

- (BOOL)isMember {
    NSString *modelId = [NSString stringWithFormat:@"%@", self.modelId];
    return [modelId isEqualToString:@"kong"] || !self.isFromMine;
}


- (void)saveButtonClicked:(UIButton *)button
{
    IWAddUserInfoParam *param = [[IWAddUserInfoParam alloc] init];
    param.loginId = [IWUserTool user].loginId; // 登录 ID
    param.companyId = @(IWCompanyId); // 公司id
    param.userName = [_model.userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // 姓名
    param.relationship = _model.relationship; // 关系(0 本人 1家人 2 其他人)
    param.gender = _model.gender; // 性别(字典 gender)
    param.genderRemark = @"";// 性别 3 时的描述
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    //先设置给定的字符串是什么格式的例如yyyyMMddHHmmss
    [dateFormat1 setLocale:[NSLocale currentLocale]];
    [dateFormat1 setDateFormat:@"yyyyMMdd"];
    [dateFormat1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDate *date1 = [dateFormat1 dateFromString:_model.birthday];
    //将日期转为指定格式
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc]init];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    [dateFormat2 setLocale:[NSLocale currentLocale]];
    //将NSDate格式时间转成什么格式的字符串例如转成M-d
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    [dateFormat2 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *resultTimeStr = [dateFormat2 stringFromDate:date1];
    param.birthday = resultTimeStr; // 出生日期
    param.communityId = _model.communityId; // 所属社区
    param.occupation = _model.occupation; // 职业(字典 occupation)
    param.education = _model.education; // 学历(字典 education)
    param.maritalStatus = _model.maritalStatus; // 婚姻状况(字典 maritalStatus)
    param.userCard = _model.userCard; // 身份证号
    param.siStatus = _model.siStatus; // 社保状态(0 无 1 有)
    param.siPlace = _model.siPlace; // 社保所属区域
    param.siCode = _model.siCode; // 公积金编号
    param.cellphone = _model.cellphone;// 手机号
    param.mail = _model.mail; // 邮箱
    param.pwd = _model.pwd; // 密码
    
    NSString *memberId = [NSString stringWithFormat:@"%@",self.modelId];
    if ([memberId isEqualToString:@"kong"]) {
        param.memberId = @"";
    } else {
        param.memberId = memberId;
    }
    
    
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWMedicalArchivesTool submitUserInfoWithParams:param isMember:[self isMember] datas:imageData success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            if (![self isMember]) {
                IWUser *user = [IWUserTool user];
                user.userName = _model.userName;
                user.communityId = _model.communityId;
                user.communityName = _model.communityName;
                user.cellphone = _model.cellphone;
                [IWUserTool saveUser:user];
                [MBProgressHUD showSuccess:NSLocalizedString(@"change_success", nil)];
            } else {
                [MBProgressHUD showSuccess:NSLocalizedString(@"change_success", nil)];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:NSLocalizedString(@"change_fail", nil)];
    }];
}

- (void)changeValue:(UITextField *)textfield{
    
    if (textfield.tag == 100001) {
        _model.userName = textfield.text;
    }else if (textfield.tag== 100002){
        _model.userCard = textfield.text;
    }else if (textfield.tag == 100003){
        _model.siCode = textfield.text;
    }else if (textfield.tag == 100004){
        _model.cellphone = textfield.text;
    }else{
        _model.mail = textfield.text;
    }
    
}

- (NSString *)timeStrTOdateTOtimeStr:(NSString *)timeStr{
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    //先设置给定的字符串是什么格式的例如yyyyMMddHHmmss
    [dateFormat1 setLocale:[NSLocale currentLocale]];
    [dateFormat1 setDateFormat:@"yyyyMMdd"];
    [dateFormat1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDate *date1 = [dateFormat1 dateFromString:timeStr];
    //将日期转为指定格式
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc]init];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    [dateFormat2 setLocale:[NSLocale currentLocale]];
    //将NSDate格式时间转成什么格式的字符串例如转成M-d
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    [dateFormat2 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *resultTimeStr = [dateFormat2 stringFromDate:date1];

    return resultTimeStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
