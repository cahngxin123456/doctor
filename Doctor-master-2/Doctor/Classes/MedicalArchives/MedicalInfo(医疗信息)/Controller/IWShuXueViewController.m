//
//  IWShuXueViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWShuXueViewController.h"
#import "IWTextFieldTableViewCell.h"
#import "IWButtonTableViewCell.h"
#import "IWJiBing.h"
#import "IWShengYuFooterView.h"
#import "IWBloodTypeViewController.h"
#import "IWMedicalArchivesTool.h"
#import "TPKeyboardAvoidingTableView.h"

#define PickViewWidth (CGRectGetWidth(_contentView.frame)-80)/3

@interface IWShuXueViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    BOOL hiddenCell;
}
@property (nonatomic, strong) NSArray *nameTitleArray;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *appView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerViewyear;
@property (nonatomic, strong) UIPickerView *pickerViewmonth;
@property (nonatomic, strong) UIPickerView *pickerViewday;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, strong) IWJiBing *currentShengYuModel;


@end

@implementation IWShuXueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableView];
    [self headerView];

}

- (NSArray *)nameTitleArray{
    if (_nameTitleArray == nil) {
        NSArray *array = @[@"原因",@"时间"];
        _nameTitleArray = array;
    }
    return _nameTitleArray;
}

- (void)setShuxueArray:(NSArray *)shuxueArray{
    _dataSource = [NSMutableArray arrayWithCapacity:0];
    _shuxueArray = shuxueArray;
    if (shuxueArray.count == 0) {
        IWJiBing *model = [[IWJiBing alloc] init];
        model.bTime = @"";
        model.bType = @"";
        model.otherType = @"";
        [_dataSource addObject:model];
    }else{
        for (IWJiBing *model in shuxueArray) {
            [_dataSource addObject:model];
        }
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


- (UIView *)headerView{
    
    if (_headerView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
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
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:CGRectMake(0, 40, IWWIDTH, IWHEIGHT - 40 -64) style:UITableViewStyleGrouped];
        tableView.backgroundColor = IWTableViewBgColor;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        return self.dataSource.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (hiddenCell) {
        return 0;
    }else{
        return 2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    IWJiBing *model = self.dataSource[indexPath.section];
    
    if (indexPath.row == 0) {
        IWTextFieldTableViewCell *cell = [IWTextFieldTableViewCell normalTableViewCellWithTableView:tableView];
        cell.nameLabel.text = @"原因";
        cell.textfield.delegate = self;
        cell.textfield.text = model.bType;
        cell.textfield.tag = indexPath.section;
        cell.textfield.placeholder = @"请填写原因";
        return cell;
    }else{
        IWButtonTableViewCell *cell = [IWButtonTableViewCell normalTableViewCellWithTableView:tableView];
        
        cell.nameLabel.text = @"时间";
        if (model.bTime.length == 0) {
            cell.resultLabel.text = @"请选择时间";
        }else{
            cell.resultLabel.text = model.bTime;
        }
        
        return cell;
    }
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
    if (indexPath.row == 1) {
        [self showPickerViewwithtitleLabele:@"时间" anddataArray:nil andIndexpath:indexPath];
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
    IWShengYuFooterView *view = [IWShengYuFooterView customViewWithFrame:CGRectMake(0, 0, IWWIDTH, 180)];
    if (self.dataSource.count == 1 || hiddenCell) {
        view.deleteButton.hidden = YES;
    }else{
        view.deleteButton.hidden = NO;
    }
    if (hiddenCell) {
        view.addButton.hidden = YES;
    }else{
        view.addButton.hidden = NO;
    }
    
    //删除
    [view setDeleteButtonBlock:^{
        [self.dataSource removeLastObject];
        [_tableView reloadData];
    }];
    
    
    //添加
    [view setAddButtonBlock:^{
        IWJiBing *model = [[IWJiBing alloc] init];
        model.bTime = @"";
        model.bType = @"";
        model.otherType = @"";
        [_dataSource addObject:model];
        [_tableView reloadData];
    }];
    
    //保存数据
    [view setSaveButtonBlock:^{
        
        NSArray *resultArray = (NSArray *)self.dataSource;
        NSMutableArray *subArray = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<resultArray.count; i++) {
            IWJiBing *model = resultArray[i];
            NSString *kong = @"";
            NSString *s1 = [NSString stringWithFormat:@"%@",model.otherType?model.otherType:kong];
            NSString *s2 = [NSString stringWithFormat:@"%@",model.bType?model.bType:kong];
            NSString *s3 = [NSString stringWithFormat:@"%@",model.bTime?model.bTime:kong];
            NSDictionary *dic = @{@"otherType":s1,@"bType":s2,@"bTime":s3};
            [subArray addObject:dic];
        }
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:subArray options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        IWAddOld3Param *param = [[IWAddOld3Param alloc] init];
        if (hiddenCell) {
            param.loginId =self.memberID;
            param.companyId = @(IWCompanyId);
            param.noValue = @"1";
            
        }else{
            param.loginId =self.memberID;
            param.companyId = @(IWCompanyId);
            param.shuxueDatas = jsonString;
            param.noValue = @"0";
            
        }
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        
        [IWMedicalArchivesTool addMedicalOld3WithParam:param success:^(IWBaseResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                if (hiddenCell) {
                    NSArray *array;
                    if (_saveButtonBlock) {
                        _saveButtonBlock(array);
                    }
                    
                }else{
                    if (_saveButtonBlock) {
                        _saveButtonBlock(resultArray);
                    }
                    
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];

        }];
        
    }];
    
    if (hiddenCell) {
        return view;
    }else{
        if (section == self.dataSource.count - 1) {
            return view;
        }else if (section == 0){
            return nil;
        }else{
            UIView *view = [[UIView alloc] init];
            view.frame = CGRectMake(0, 0, IWWIDTH, 30);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(IWWIDTH - 105, 5, 70, 20);
            button.backgroundColor=[UIColor clearColor];
            [button addTarget:self action:@selector(deletebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = section;
            [button setTitle:@"删除" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [button setTintColor:[UIColor orangeColor]];
            [button.layer setBorderWidth:1.5];
            button.titleLabel.font = IWFont;
            [button.layer setBorderColor:[UIColor orangeColor].CGColor];
            [view addSubview:button];
            return view;
        }
    }
    
    
}

- (void)deletebuttonClicked:(UIButton *)btn{
    if (btn.tag) {
        
        [self.dataSource removeObjectAtIndex:btn.tag];
        [_tableView reloadData];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (hiddenCell) {
        return 180;
    }else{
        if (section == self.dataSource.count - 1) {
            return 180;
        }else if (section == 0){
            return 20;
        }else{
            return 30;
        }
        
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
    
    NSString *timeStr;
    for (int i = 0; i<self.dataSource.count; i++) {
        if (i == index.section) {
            self.currentShengYuModel = self.dataSource[i];
            timeStr = self.currentShengYuModel.bTime;
        }
    }
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    //先设置给定的字符串是什么格式的例如yyyyMMddHHmmss
    [dateFormat1 setLocale:[NSLocale currentLocale]];
    [dateFormat1 setDateFormat:@"yyyy MMdd"];
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
    
    if (self.dataSource.count == 0) {
        NSUInteger year = [self.timeArray[0] indexOfObject:@"2016"];
        if(year != NSNotFound)
        {
            [_pickerViewyear selectRow:year inComponent:0 animated:YES];
        }
    }else{
        NSUInteger year = [self.timeArray[0] indexOfObject:array[0]];
        if(year != NSNotFound)
        {
            [_pickerViewyear selectRow:year inComponent:0 animated:YES];
        }
        
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
    
    //添加取消 和 保存button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(0, 250 , CGRectGetWidth(_contentView.frame)/2, 50);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:cancelButton];
    
    UIButton *soButton = [UIButton buttonWithType:UIButtonTypeSystem];
    soButton.frame = CGRectMake(CGRectGetWidth(_contentView.frame)/2, 250,CGRectGetWidth(_contentView.frame)/2, 50);
    soButton.tag = index.row;
    [soButton setTitle:@"保存" forState:UIControlStateNormal];
    [soButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
    soButton.backgroundColor = [UIColor whiteColor];
    [soButton addTarget:self action:@selector(timesaveButton:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:soButton];
}



- (void)cancelAction
{
    [self.appView removeFromSuperview];
    [self.contentView removeFromSuperview];
}

- (void)timesaveButton:(UIButton *)btn
{
    [self.appView removeFromSuperview];
    [self.contentView removeFromSuperview];
    
    NSUInteger yearrow = [self.pickerViewyear selectedRowInComponent:0];
    NSString *yearStr = self.timeArray[0][yearrow];
    
    NSUInteger monthrow = [self.pickerViewmonth selectedRowInComponent:0];
    NSString *monthStr = self.timeArray[1][monthrow];
    
    NSUInteger dayRow = [self.pickerViewday selectedRowInComponent:0];
    NSString *dayStr = self.timeArray[2][dayRow];
    
    self.currentShengYuModel.bTime = [NSString stringWithFormat:@"%@%@%@",yearStr,monthStr,dayStr];
    
    [_tableView reloadData];
    
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
        myView.textColor = IWGlobalColor;
        
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

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
    IWJiBing *model = self.dataSource[textField.tag];
    model.bType = textField.text;
    
}


@end
