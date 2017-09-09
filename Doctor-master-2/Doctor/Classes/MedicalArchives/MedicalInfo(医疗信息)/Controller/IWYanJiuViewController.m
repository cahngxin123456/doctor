//
//  IWYanJiuViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWYanJiuViewController.h"
#import "IWTextFieldTableViewCell.h"
#import "IWButtonTableViewCell.h"
#import "IWBloodTypeViewController.h"
#import "IWMedicalArchivesTool.h"
#import "TPKeyboardAvoidingTableView.h"

@interface IWYanJiuViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    BOOL hiddenCell;
}
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, copy) NSString *drinkType;
@property (nonatomic, copy) NSString *otherDrinktype;



@end

@implementation IWYanJiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self headerView];
    [self tableView];
}

- (void)setYanjiuModel:(IWYanJiu *)yanjiuModel{
    _yanjiuModel = yanjiuModel;
    
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
        _headerView= view;
    }
    return _headerView;
}

- (void)headerbuttonClicked:(UIButton *)btn{
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
        tableView.scrollEnabled = NO;
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
    if (hiddenCell) {
        return 0;
    }else{
        return 7;

    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        IWButtonTableViewCell *buttoncell = [IWButtonTableViewCell normalTableViewCellWithTableView:tableView];
        buttoncell.nameLabel.text = @"种类";
        NSString *kong = @"";
        NSString *str1 = [NSString stringWithFormat:@"%@",self.yanjiuModel.wineType?self.yanjiuModel.wineType:kong];
        NSString *str2 = [NSString stringWithFormat:@"%@",self.yanjiuModel.otherWineType?self.yanjiuModel.otherWineType:kong];
        NSString *str = [NSString stringWithFormat:@"%@ %@",str1,str2];
        NSMutableString *ms = [NSMutableString stringWithFormat:@"%@",str];
        NSString *resultStr =[ms stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (resultStr.length == 0) {
            buttoncell.resultLabel.text =@"请选择酒种类";
            buttoncell.resultLabel.textColor = [UIColor lightGrayColor];

        }else{
            buttoncell.resultLabel.text =str;
            buttoncell.resultLabel.textColor = [UIColor grayColor];

        }
        return buttoncell;
        
    }else
    {
        IWTextFieldTableViewCell *textFieldcell = [IWTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
        textFieldcell.textfield.delegate = self;
        textFieldcell.textfield.keyboardType = UIKeyboardTypeNumberPad;
        if (indexPath.row == 0) {
            textFieldcell.textfield.enabled = NO;
            textFieldcell.textfield.borderStyle = UITextBorderStyleNone;
            textFieldcell.nameLabel.font = [UIFont boldSystemFontOfSize:14];
            textFieldcell.textfield.backgroundColor = [UIColor clearColor];
            textFieldcell.nameLabel.text = @"吸烟";
        }
        
        if (indexPath.row == 1) {
            textFieldcell.nameLabel.text = @"时长";
            textFieldcell.rightLabel.text = @"年";
            
            textFieldcell.textfield.text = self.yanjiuModel.smokeYear;
            textFieldcell.textfield.placeholder = @"请输入吸烟时长";
            textFieldcell.textfield.tag = 100 + indexPath.row;
            
        }
        if (indexPath.row == 2) {
            textFieldcell.nameLabel.text = @"数量";
            textFieldcell.rightLabel.text = @"支/天";
            textFieldcell.textfield.text = self.yanjiuModel.smokeNum;
            textFieldcell.textfield.tag = 100 + indexPath.row;
            textFieldcell.textfield.placeholder = @"请输入每天多少支";

        }
        if (indexPath.row == 3) {
            textFieldcell.textfield.borderStyle = UITextBorderStyleNone;
            textFieldcell.textfield.enabled = NO;
            textFieldcell.nameLabel.font = [UIFont boldSystemFontOfSize:14];
            textFieldcell.textfield.backgroundColor = [UIColor clearColor];
            textFieldcell.nameLabel.text = @"饮酒";


        }
        if (indexPath.row == 4) {
            textFieldcell.nameLabel.text = @"时长";
            textFieldcell.rightLabel.text = @"年";
            textFieldcell.textfield.text = self.yanjiuModel.drinkYear;
            textFieldcell.textfield.tag = 100 + indexPath.row;
            textFieldcell.textfield.placeholder = @"请输入饮酒时长";


        }
        if (indexPath.row == 5) {
            textFieldcell.nameLabel.text = @"数量";
            textFieldcell.rightLabel.text = @"两/天";
            textFieldcell.textfield.text = self.yanjiuModel.drinkNum;
            textFieldcell.textfield.tag = 100 + indexPath.row;
            textFieldcell.textfield.placeholder = @"请输入每天多少两";

        }
        return textFieldcell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 6) {
        IWBloodTypeViewController *vc = [[IWBloodTypeViewController alloc] init];
        vc.typeStr = @"DrinkType";
        vc.navigationItem.title = NSLocalizedString(@"activity_medical_info_tobacco_type_title", nil);
        
        __weak typeof(_yanjiuModel)weakModel = _yanjiuModel;
        [vc setDrinkTypeSaveBlock:^(NSString *drinkType, NSString *otherDrinkType) {
            weakModel.wineType = drinkType;
            weakModel.otherWineType = otherDrinkType;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];

        NSString *str = _yanjiuModel.wineType;
        NSArray *array = [str componentsSeparatedByString:@","];
        vc.selectArray = array;
        vc.textFieldtext = _yanjiuModel.otherWineType;

        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}
//HeaderInSection  &&  FooterInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor clearColor];
    backView.frame = CGRectMake(0, 0, IWWIDTH, 70);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10,30, self.view.frame.size.width - 20, 40);
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
    
    
    
    
    return backView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}

- (void)footerbuttonClicked:(UIButton *)btn{
    
    IWAddYanJiuParam *param = [[IWAddYanJiuParam alloc] init];
    param.companyId = @(IWCompanyId);
    param.loginId = self.memberID;

    if (hiddenCell) {
        param.noValue = @"1";
        param.smokeYear = @"";
        param.smokeNum = @"";
        param.drinkYear = @"";
        param.drinkNum = @"";
        param.wineType = @"";
        param.otherWineType = @"";

    }else{
        param.noValue = @"0";
        param.smokeYear = _yanjiuModel.smokeYear;
        param.smokeNum = _yanjiuModel.smokeNum;
        param.drinkYear = _yanjiuModel.drinkYear;
        param.drinkNum = _yanjiuModel.drinkNum;
        param.wineType = _yanjiuModel.wineType;
        param.otherWineType = _yanjiuModel.otherWineType;
    }
        
    
    
    [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
    [IWMedicalArchivesTool addMedicalYanJiuWithParam:param success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
            if (hiddenCell) {
                NSString *kong = @"";
                if (_saveButtonBlock) {
                    _saveButtonBlock(kong,kong ,kong ,kong ,kong );
                }

            }else{
                if (_saveButtonBlock) {
                    _saveButtonBlock(_yanjiuModel.smokeYear,_yanjiuModel.smokeNum,_yanjiuModel.drinkYear,_yanjiuModel.drinkNum,_yanjiuModel.wineType);
                }

            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:NSLocalizedString(@"save_fail", nil)];
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 101) {
        self.yanjiuModel.smokeYear = textField.text;
    }
    
    if (textField.tag == 102) {
        self.yanjiuModel.smokeNum = textField.text;
    }
    
    if (textField.tag == 104) {
        self.yanjiuModel.drinkYear = textField.text;
    }
    
    if (textField.tag == 105) {
        self.yanjiuModel.drinkNum = textField.text;
    }

    [_tableView reloadData];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}



@end
