//
//  IWBloodTypeViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWBloodTypeViewController.h"
#import "IMJIETagFrame.h"
#import "IMJIETagView.h"
#import "IWMedicalArchivesTool.h"

@interface IWBloodTypeViewController ()<IMJIETagViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, copy) NSString *resultStr;
@property (nonatomic, copy) NSString *resultTextFieldStr;

@property (nonatomic, strong) IMJIETagView *tagView;


@end

@implementation IWBloodTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    
    
}

- (void)setTypeStr:(NSString *)typeStr{

    _typeStr = typeStr;
    if ([_typeStr isEqualToString:@"BloodType"]) {
        self.dataArray = @[@"A型血",@"B型血",@"AB型血",@"O型血",@"Rh阴型血",@"Rh阳型血"];
    }
    
    if ([_typeStr isEqualToString:@"JiBing"]) {
        self.dataArray = @[@"高血压",@"慢性阻塞性肺疾病",@"恶性肿瘤",@"脑卒中",@"结核病",@"糖尿病",@"冠心病",@"肝炎",@"其他法定传染病",@"职业病"];
    }

    
    if ([_typeStr isEqualToString:@"YiChuan"]) {
        self.dataArray = @[@"多指症",@"镰刀型细胞贫血症",@"结肠息肉",@"白化病",@"黑尿症",@"脊柱炎",@"冠心病",@"哮喘",@"类风湿性关节炎",@"支气管"];
    }

    if ([_typeStr isEqualToString:@"CanJi"]) {
        self.dataArray = @[@"听力残疾",@"视力残疾",@"精神残疾",@"言语残疾",@"肢体残疾",@"智力残疾"];
    }

    if ([_typeStr isEqualToString:@"DuanLian"]) {
        self.dataArray = @[@"每周<3次",@"每周>3次",@"无规律"];
    }

    if ([_typeStr isEqualToString:@"DrinkType"]) {
        self.dataArray = @[@"白酒",@"红酒",@"黄酒",@"啤酒",@"杨梅酒",@"人参酒"];
    }
    
    if ([_typeStr isEqualToString:@"BaoLu"]) {
        self.dataArray = @[@"化学品",@"毒物",@"射线"];
    }
    
}

- (void)setupUI{
    if ([_typeStr isEqualToString:@"BaoLu"]) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 10, IWWIDTH - 20, 30);
        label.text = NSLocalizedString(@"activity_medical_expose_tip", nil);
        label.textColor = IWBlueColor;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = IWFont;
        [self.view addSubview:label];
    }
    
    
    IMJIETagFrame *frame = [[IMJIETagFrame alloc] init];
    frame.tagsMinPadding = 4;
    frame.tagsMargin = 10;
    frame.tagsLineSpacing = 10;
    frame.tagsArray = self.dataArray;
    if ([_typeStr isEqualToString:@"BaoLu"]) {
        self.tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, frame.tagsHeight)];
    }else{
        self.tagView = [[IMJIETagView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, frame.tagsHeight)];
    }

    self.tagView.clickbool = YES;
    self.tagView.borderSize = 0.5;
    self.tagView.clickborderSize = 0.5;
    self.tagView.tagsFrame = frame;
    if ([_typeStr isEqualToString:@"YiChuan"]  || [_typeStr isEqualToString:@"CanJi"] || [_typeStr isEqualToString:@"DrinkType"] || [_typeStr isEqualToString:@"BaoLu"]) {
        self.tagView.clickStart = 1;
        self.tagView.clickArray = self.selectArray;
    }else{
        self.tagView.clickStart = 0;//0-单选   1-多选
        self.tagView.clickString = self.selectedName;
    }
    self.tagView.delegate = self;
    
    [self.view addSubview:self.tagView];

    //添加textField
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(20, CGRectGetMaxY(self.tagView.frame),IWWIDTH - 40, 36);
    textField.borderStyle =  UITextBorderStyleRoundedRect;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.font = [UIFont systemFontOfSize:14];
    textField.backgroundColor = [UIColor clearColor];
    textField.textColor = [UIColor grayColor];
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if (_textFieldtext.length == 0) {
        textField.placeholder = NSLocalizedString(@"other_one_tip", nil);

    }else{
        textField.text = _textFieldtext;
    }
    [self.view addSubview:textField];
    _textField = textField;

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, CGRectGetMaxY(_textField.frame) + 10 , IWWIDTH - 20, 40);
    [button addTarget:self action:@selector(savebuttonClicked) forControlEvents:UIControlEventTouchUpInside];
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
    [self.view addSubview:button];
    _saveButton=button;

    
}

- (void)savebuttonClicked
{
    [_textField resignFirstResponder];

    if ([_typeStr isEqualToString:@"JiBing"] ) {
        
        
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = self.selectedName;
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }

        if (_drinkTypeSaveBlock) {
            _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
        }


    }
    
    
    if ([_typeStr isEqualToString:@"DrinkType"] ) {
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = [self.selectArray componentsJoinedByString:@","];
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }
        if (_drinkTypeSaveBlock) {
            _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
        }

        
    }
    if ([_typeStr isEqualToString:@"BloodType"]) {
        
        IWAddBloodparam *param = [[IWAddBloodparam alloc] init];
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = self.selectedName;
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }
        param.bloodType = finallySelectTitle;
        param.otherBloodType = finallyTextfieldText;

        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalBloodWithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (_drinkTypeSaveBlock) {
                    _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
                }

            }else{
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
    }
    
    if ([_typeStr isEqualToString:@"YiChuan"]) {
        IWAddYiChuanParam *param = [[IWAddYiChuanParam alloc] init];
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = [self.selectArray componentsJoinedByString:@","];
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }

        param.geneticName = finallySelectTitle;
        param.otherName = finallyTextfieldText;
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];

        [IWMedicalArchivesTool addMedicalYiChuanWithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (_drinkTypeSaveBlock) {
                    _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
                }

            }else{
                [MBProgressHUD showSuccess:result.info];
            }

        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];

        }];
        
    }
    
    if ([_typeStr isEqualToString:@"CanJi"]) {
        IWAddCanjiParam *param = [[IWAddCanjiParam alloc] init];
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = [self.selectArray componentsJoinedByString:@","];
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }
        param.disabilityName = finallySelectTitle;
        param.otherName = finallyTextfieldText;
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.noValue = @"0";
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];

        [IWMedicalArchivesTool addMedicalCanjiWithParam:param success:^(IWBaseResult *result) {
            
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (_drinkTypeSaveBlock) {
                    _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
                }

            }else{
                [MBProgressHUD showSuccess:result.info];
            }

        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];

        }];
    }
    
    if ([_typeStr isEqualToString:@"DuanLian"]) {
        IWAddDuanLianParam *param = [[IWAddDuanLianParam alloc] init];
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = [self.selectArray componentsJoinedByString:@","];
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }

        param.exercise = finallySelectTitle;
        param.otherexercise = finallyTextfieldText;
        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.noValue = @"0";
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];

        [IWMedicalArchivesTool addMedicalDuanLianWithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (_drinkTypeSaveBlock) {
                    _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
                }
            }else{
                [MBProgressHUD showSuccess:result.info];
            }

        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
    }
    
    
    if ([_typeStr isEqualToString:@"BaoLu"]) {
        
        IWAddBaoLuParam *param = [[IWAddBaoLuParam alloc] init];
        NSString *finallySelectTitle;
        NSString *finallyTextfieldText;
        if (self.resultStr.length == 0) {
            finallySelectTitle = [self.selectArray componentsJoinedByString:@","];
        }else{
            finallySelectTitle = self.resultStr;
        }
        if (self.resultTextFieldStr.length == 0) {
            finallyTextfieldText = self.textFieldtext;
        }else{
            finallyTextfieldText = self.resultTextFieldStr;
        }

        param.loginId = self.memberID;
        param.companyId = @(IWCompanyId);
        param.exposeName = finallySelectTitle;
        param.otherExposeName = finallyTextfieldText;
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalBaoLuWithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (_drinkTypeSaveBlock) {
                    _drinkTypeSaveBlock(finallySelectTitle, finallyTextfieldText);
                }
            }else{
                [MBProgressHUD showSuccess:result.info];
            }
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
        }];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 选中
-(void)IMJIETagView:(NSArray *)tagArray{
    
    NSLog(@"%@",tagArray);
    NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
    //遍历取出选中的title
    for (int i = 0; i<tagArray.count; i++) {
        //获取选中的下标
        int n = [tagArray[i] intValue];
        //根据下标找到title
        [resultArray addObject:self.dataArray[n]];
    }
    //拼接成字符串
    NSString *resulrstr = [resultArray componentsJoinedByString:@","];
    self.resultStr = resulrstr;
    if (self.resultStr.length == 0) {
        self.selectedName = @"";
        self.selectArray = nil;
    }
}

#pragma mark - textField delegit

- (void) textFieldDidChange:(UITextField*) sender {
    
    self.resultTextFieldStr = sender.text;

    if (self.resultTextFieldStr.length == 0) {
        self.textFieldtext = @"";
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
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
