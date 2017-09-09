//
//  IWGuoMinViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWGuoMinViewController.h"
#import "IWMedicalArchivesTool.h"
#import "IWGuoMinTableViewCell.h"
#import "TPKeyboardAvoidingTableView.h"

@interface IWGuoMinViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    BOOL hiddenCell;
}
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, weak) UIButton *selectedButton;

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, strong) NSArray *headerTitleArray;
@property (nonatomic, strong) NSArray *titleArray;


//@property (nonatomic, copy) NSString *mediclalName;
//@property (nonatomic, copy) NSString *otherMdeicalName;
//@property (nonatomic, copy) NSString *foodName;
//@property (nonatomic, copy) NSString *otherFoodName;
//@property (nonatomic, copy) NSString *otherName;
//@property (nonatomic, copy) NSString *otherOtherName;

@property (nonatomic ,assign) CGFloat onecellHeight;
@property (nonatomic ,assign) CGFloat twocellHeight;
@property (nonatomic ,assign) CGFloat threecellHeight;

@property (nonatomic, weak) UITextField *firstTextField;
@property (nonatomic, weak) UITextField *secondTetfield;
@property (nonatomic, weak) UITextField *thirdTextfield;



@end

@implementation IWGuoMinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];

    [self headerView];
}


- (void)setGuominModel:(IWGuoMin *)guominModel{
    _guominModel = guominModel;
}

- (NSArray *)headerTitleArray{
    if (_headerTitleArray == nil) {
        NSArray *array = @[@"药物过敏",@"食物过敏",@"其他过敏"];
        _headerTitleArray = array;
    }
    return _headerTitleArray;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:0];
        NSArray *array1 = @[@"青霉素",@"破伤风抗毒素(TAT)",@"普罗卡因",@"地卡因",@"磺胺类",@"链霉素",@"头孢类",@"维生素B1",@"阿司匹林",@"泛影葡胺"];
        NSArray *array2 = @[@"鸡蛋",@"芒果",@"牛奶",@"海鲜",@"香菇",@"桃子",@"榴莲",@"黄桃"];
        NSArray *array3 = @[@"花粉",@"尘螨",@"毛发",@"霉菌",@"乳胶",@"燃料",@"化妆品"];
        [muArray addObject:array1];
        [muArray addObject:array2];
        [muArray addObject:array3];
        _titleArray = (NSArray *)muArray;
    }
    return _titleArray;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = IWTableViewBgColor;
        view.frame = CGRectMake(0, 0, IWWIDTH, 40);
        
        UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        oneButton.frame = CGRectMake(CGRectGetMidX(view.frame) - 100, 0, 100, 40);
        oneButton.tag=1;
        oneButton.selected = YES;
        [oneButton addTarget:self action:@selector(headerbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [oneButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        oneButton.titleLabel.font = IWFont;
        [oneButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [oneButton setTitle:@"有" forState:UIControlStateNormal];
        [oneButton setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [oneButton setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        
        self.selectedButton = oneButton;
        [view addSubview:oneButton];
        
        UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        twoButton.frame = CGRectMake(CGRectGetMidX(view.frame), 0, 100, 40);
        twoButton.tag=2;
        [twoButton addTarget:self action:@selector(headerbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        twoButton.titleLabel.font = IWFont;
        [twoButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [twoButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [twoButton setTitle:@"无" forState:UIControlStateNormal];
        [twoButton setImage:[UIImage imageNamed:@"choose_btn"] forState:UIControlStateNormal];
        [twoButton setImage:[UIImage imageNamed:@"choose_btn_highlighted"] forState:UIControlStateSelected];
        [view addSubview:twoButton];
        [self.view addSubview:view];
        _headerView = view;
        
    }
    
    return _headerView;
}

- (void)headerbuttonClicked:(UIButton*)btn{
    if (!btn.isSelected) {
        
        self.selectedButton.selected = !self.selectedButton.selected;
        btn.selected = !btn.selected;
        self.selectedButton = btn;
        
    }
    UIButton *button = btn;
    if (button.tag == 2) {
        hiddenCell = YES;
        [_tableView reloadData];
    }else{
        hiddenCell = NO;
        [_tableView reloadData];
    }

    
}


- (TPKeyboardAvoidingTableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 40, IWWIDTH, IWHEIGHT - 40 - 64) style:UITableViewStyleGrouped];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view insertSubview:tableView atIndex:1];
        _tableView = tableView;
    }
    return _tableView ;
}
#pragma mark - tableView delegate and tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (hiddenCell) {
        return 1;
    }else{
        return 3;

    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (hiddenCell) {
        return 0;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4;
    frame.tagsMargin = 10;
    frame.tagsLineSpacing = 10;
    frame.tagsArray = self.titleArray[indexPath.section];
    return frame.tagsHeight + 80;
 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWGuoMinTableViewCell *cell = [IWGuoMinTableViewCell normalTableViewCellWithTableView:tableView];
    NSArray *medicineNameArray = [self.guominModel.medicineName
                                  componentsSeparatedByString:@","];
    NSArray *footNameArray = [self.guominModel.footName componentsSeparatedByString:@","];
    NSArray *otherNamearray = [self.guominModel.otherName componentsSeparatedByString:@","];
//    NSArray *otherMedicineNamearray = [self.guominModel.otherMedicineName
//                                       componentsSeparatedByString:@","];
//    NSArray *otherFootNamearray = [self.guominModel.otherOtherName
//                                   componentsSeparatedByString:@","];
//    NSArray *otherOtherNamearray = [self.guominModel.otherOtherName
//                                    componentsSeparatedByString:@","];
    
    __weak typeof(_guominModel)wm = _guominModel;
    if (indexPath.section == 0) {
        cell.dataArray = self.titleArray[indexPath.section];
        cell.selectArray = medicineNameArray;
        cell.textField.text = self.guominModel.otherMedicineName;
        cell.othername = self.guominModel.otherMedicineName;
        [cell setGuominCellBlock:^(NSString *s1) {
            wm.medicineName = s1;
        }];
        cell.textField.delegate = self;
        self.firstTextField = cell.textField;

        cell.textField.tag = indexPath.section + 100;
    }else if (indexPath.section == 1){
        cell.dataArray = self.titleArray[indexPath.section];
        cell.selectArray = footNameArray;
        cell.othername = self.guominModel.otherFootName;
        [cell setGuominCellBlock:^(NSString *s1) {
            wm.footName = s1;
        }];
        cell.textField.delegate = self;
        cell.textField.text = self.guominModel.otherFootName;
        self.secondTetfield = cell.textField;

        cell.textField.tag = indexPath.section + 100;

    }else{
        cell.dataArray = self.titleArray[indexPath.section];
        cell.selectArray = otherNamearray;
        cell.othername = self.guominModel.otherName;
        [cell setGuominCellBlock:^(NSString *s1) {
            wm.otherName = s1;
        }];
        cell.textField.delegate = self;
        cell.textField.text = self.guominModel.otherOtherName;
        self.thirdTextfield = cell.textField;

        cell.textField.tag = indexPath.section + 100;
    }
    
    return cell;
}
//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (hiddenCell) {
        return nil;
    }else{
        UIView *backView = [[UIView alloc]init];
        backView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 10, IWWIDTH - 20, 40);
        label.text = self.headerTitleArray[section];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [backView addSubview:label];
        return backView;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (hiddenCell) {
        return 0.0001;
    }else{
        return 60;
        
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, IWWIDTH, 70);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,10, self.view.frame.size.width - 20, 40);
    [button addTarget:self action:@selector(footerbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10;
    
    NSArray *imageNameArray = @[@"t_btn_normal",@"t_btn_press"];
    for (int i = 0; i<2; i++) {
        // 加载图片
        UIImage *image = [UIImage imageNamed:imageNameArray[i]];
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        
        if (i == 0) {
            [button setBackgroundImage:newImage forState:UIControlStateNormal];
            
        }else
        {
            [button setBackgroundImage:newImage forState:UIControlStateHighlighted];
        }
    }
    
    [backView addSubview:button];
    
    if (hiddenCell) {
        return backView;
    }else{
        if (section == 2) {
            return backView;
        }else{
            return nil;
        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (hiddenCell) {
        return 70;
    }else{
        if (section == 2) {
            return 70;
        }else{
            return 0.0001;
        }
    }
}


- (void)footerbuttonClicked:(UIButton *)btn{
    
    [_firstTextField resignFirstResponder];
    [_thirdTextfield resignFirstResponder];
    [_secondTetfield resignFirstResponder];
    IWAddGuoMinParam *param = [[IWAddGuoMinParam alloc] init];
    if (hiddenCell) {
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.noValue = @"1";
        param.medicineName = @"";
        param.otherMedicineName = @"";
        param.footName = @"";
        param.otherFootName = @"";
        param.otherName = @"";
        param.otherOtherName = @"";

    }else{
        param.noValue = @"0";
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.medicineName = _guominModel.medicineName;
        param.otherMedicineName = _guominModel.otherMedicineName;
        param.footName = _guominModel.footName;
        param.otherFootName = _guominModel.otherFootName;
        param.otherName = _guominModel.otherName;
        param.otherOtherName = _guominModel.otherOtherName;

    }
    
    
    [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
    [IWMedicalArchivesTool addMedicalGuoMinWithParam:param success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
            if (hiddenCell) {
                if (_saveButtonBlock) {
                    NSString *kong = @"";
                    _saveButtonBlock(kong,kong,kong,kong,kong,kong);
                }

            }else{
                if (_saveButtonBlock) {
                    _saveButtonBlock(param.medicineName,param.otherMedicineName,param.footName,param.otherFootName,param.otherName,param.otherOtherName);
                }

            }
            
        }else{
            [MBProgressHUD showSuccess:result.info];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        _guominModel.otherMedicineName = textField.text;
        
    }
    
    if (textField.tag == 101) {
        _guominModel.otherFootName = textField.text;
    }

    if (textField.tag == 102) {
        _guominModel.otherOtherName = textField.text;
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
