//
//  IWAddDataPressBtnViewController.m
//  Doctor
//
//  Created by 深水区 on 16/12/25.
//
//

#import "IWAddDataPressBtnViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IWTextView.h"
#import "MBProgressHUD.h"
#import "IWMedicalArchivesTool.h"
#import "IWToast.h"
#import "IWPressureAndSugerDetailViewController.h"
#import "IWPressureAndSugerDetailViewController.h"

@interface IWAddDataPressBtnViewController ()<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) NSArray *headrTitleArray;
@property (nonatomic, weak) TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *pickView;
@property (nonatomic, weak) UIView *timeView;
@property (nonatomic, weak) UITextField *inputTimeView;
@property (nonatomic, weak) UIView *textView;
@property (nonatomic, weak) IWTextView *inputTextView;
@property (nonatomic, weak) UIButton *saveButton;
@property (nonatomic, strong) NSArray *firstPickerDataSource;
@property (nonatomic, strong) NSArray *secondPickerDataSource;
@property (nonatomic, strong) NSArray *thirdPickerDataSource;

@property (nonatomic, weak) UIDatePicker *beginDatePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, copy) NSString *text1;
@property (nonatomic, copy) NSString *text2;
@property (nonatomic, copy) NSString *text3;
@end

@implementation IWAddDataPressBtnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.formatter = formatter;
    
    [self scrollView];
    [self headrTitleArray];

    [self headerView];
    [self timeView];
    [self setupTimeView];
    [self textView];
    [self saveButton];
    
   
    
}

- (NSArray *)headrTitleArray{
    if (_headrTitleArray == nil) {
        if ([self.type isEqualToString:@"BloodPressure"]) {
            NSArray *array = @[@"高压\nmmHg",@"低压\nmmHg",@"心率\nbpm"];
            _headrTitleArray = array;
            
        }else{
            NSArray *array = @[@"时段",@"血糖值\nmmol/L"];
            
            _headrTitleArray = array;
        }
        
    }
    return _headrTitleArray;
}

- (NSArray *)firstPickerDataSource{
    if (_firstPickerDataSource == nil) {
    
        if ([self.type isEqualToString:@"BloodPressure"]) {

            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            for (int i = 50; i<200; i++) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                
                [array addObject:str];
            }
            _firstPickerDataSource = (NSArray *)array;
            
        }else{
            NSArray *array = @[@"空腹",@"早餐前",@"早餐后",@"午餐前",@"午餐后",@"晚餐前",@"晚餐后"];
            _firstPickerDataSource = array;
        }
        
    }
    return _firstPickerDataSource;
}

- (NSArray *)secondPickerDataSource{
    if (_secondPickerDataSource == nil) {
        
        if ([self.type isEqualToString:@"BloodPressure"]) {
            
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            for (int i = 30; i<100; i++) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                
                [array addObject:str];
            }
            _secondPickerDataSource = (NSArray *)array;
            
            
        }else{
            NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            _secondPickerDataSource = array;
        }

        
        
    }
    
    return _secondPickerDataSource;
}

- (NSArray *)thirdPickerDataSource{
    if (_thirdPickerDataSource == nil) {
        if ([self.type isEqualToString:@"BloodPressure"]) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            for (int i = 40; i<100; i++) {
                NSString *str = [NSString stringWithFormat:@"%d",i];
                
                [array addObject:str];
            }
            _thirdPickerDataSource = (NSArray *)array;
            
        }else{
            NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
            _thirdPickerDataSource = array;
        }

    }

    return _thirdPickerDataSource;
}

- (TPKeyboardAvoidingScrollView *)scrollView{
    if (_scrollView == nil) {
        TPKeyboardAvoidingScrollView *view = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        view.delegate = self;
        view.contentSize = CGSizeMake(IWWIDTH, IWHEIGHT + 200);
        view.scrollEnabled = NO;
        [self.view addSubview:view];
        _scrollView = view;
        
    }
    return _scrollView;
}

- (UIView *)headerView{
    if (_headerView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IWWIDTH, 40)];
        view.backgroundColor = IWTableViewBgColor;
        for (int i = 0; i<_headrTitleArray.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake((self.view.frame.size.width-20) / _headrTitleArray.count * i, 0, (self.view.frame.size.width-20) / _headrTitleArray.count , 42);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor grayColor];
            label.numberOfLines = 2;
            label.text = self.headrTitleArray[i];
            label.textColor= [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14];
            [view addSubview:label];
        }
        
        [self.scrollView addSubview:view];
        _headerView = view;
    }
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    for (UIView *view in [self.pickView subviews]) {
        if ([view isKindOfClass:[UIPickerView class]]) {
            UIPickerView *p = (UIPickerView *)view;
            if (p.tag == 1) {
                if ([self.type isEqualToString:@"BloodPressure"]) {
                    [self pickerView:p didSelectRow:[self.firstPickerDataSource indexOfObject:@"120"] inComponent:0];

                }else{
                  
                    [self pickerView:p didSelectRow:self.firstPickerDataSource.count * 0.5 inComponent:0];

                }

                
            }
            else if (p.tag == 2)
            {
                if ([self.type isEqualToString:@"BloodPressure"]) {
                    [self pickerView:p didSelectRow:[self.secondPickerDataSource indexOfObject:@"80"] inComponent:0];
                }else{
                    [self pickerView:p didSelectRow:self.secondPickerDataSource.count * 0.5 inComponent:0];
                }

            }
            else if (p.tag == 3)
            {
                
                if ([self.type isEqualToString:@"BloodPressure"]) {
                    [self pickerView:p didSelectRow:[self.thirdPickerDataSource indexOfObject:@"70"] inComponent:0];
                }else{
                    [self pickerView:p didSelectRow:self.thirdPickerDataSource.count * 0.5 inComponent:0];
                }

            }

            
        }
    }

}

- (UIView *)pickView{
    if (_pickView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), IWWIDTH, 200)];
        UIPickerView *pickerView1 = [[UIPickerView alloc] initWithFrame:CGRectMake(20, 0, (IWWIDTH -80)/ 3, 200)];
        
        
        pickerView1.delegate = self;
        pickerView1.dataSource = self;
        pickerView1.tag = 1;
        
        if ([self.type isEqualToString:@"BloodPressure"]) {
            [pickerView1 selectRow:[self.firstPickerDataSource indexOfObject:@"120"] inComponent:0 animated:YES];
            self.text1 = @"120";
        }else{
            [pickerView1 selectRow:self.firstPickerDataSource.count * 0.5 inComponent:0 animated:YES];
                     self.text1 = @"早餐前";
        }

        
        
        [view addSubview:pickerView1];
        
        UIPickerView *pickerView2 = [[UIPickerView alloc] initWithFrame:CGRectMake((IWWIDTH-80)/3 + 40, 0, (IWWIDTH - 80)/ 3, 200)];
        pickerView2.delegate = self;
        pickerView2.dataSource = self;
        pickerView2.tag = 2;
        
        if ([self.type isEqualToString:@"BloodPressure"]) {
            [pickerView2 selectRow:[self.secondPickerDataSource indexOfObject:@"80"] inComponent:0 animated:YES];
            self.text2 = @"80";
        }else{
            [pickerView2 selectRow:self.secondPickerDataSource.count * 0.5 inComponent:0 animated:YES];
            self.text2 = @"5";
        }

        
        [view addSubview:pickerView2];
        
        UIPickerView *pickerView3 = [[UIPickerView alloc] initWithFrame:CGRectMake((IWWIDTH-80) / 3 * 2 + 60, 0, (IWWIDTH - 80)/ 3, 200)];
        pickerView3.delegate = self;
        pickerView3.dataSource = self;
        pickerView3.tag = 3;
     
        if ([self.type isEqualToString:@"BloodPressure"]) {
            [pickerView3 selectRow:[self.thirdPickerDataSource indexOfObject:@"70"] inComponent:0 animated:YES];
            self.text3 = @"70";
        }else{
            [pickerView3 selectRow:self.thirdPickerDataSource.count * 0.5 inComponent:0 animated:YES];
            self.text3 = @"5";
        }
        
        [view addSubview:pickerView3];

        
        view.backgroundColor = [UIColor whiteColor];
        
        [self.scrollView addSubview:view];
        self.pickView = view;
         }
    return _pickView;
}



//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (pickerView.tag == 1) {
        return self.firstPickerDataSource.count;
    }else if (pickerView.tag == 2){
        return self.secondPickerDataSource.count;
    }else{
        return self.thirdPickerDataSource.count;
    }
    
}

#pragma mark UIPickerView Delegate Method 代理方法
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (pickerView.tag == 1) {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
        
        myView.textAlignment = NSTextAlignmentCenter;
        myView.textColor = IWBlueColor;

        myView.text = [self.firstPickerDataSource objectAtIndex:row];
        
        myView.font = [UIFont systemFontOfSize:15];         //用label来设置字体大小
        myView.backgroundColor = [UIColor clearColor];
        
        myView.textColor = [UIColor lightGrayColor];

    
    
    }else if (pickerView.tag == 2)
    {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
        
        myView.text = [self.secondPickerDataSource objectAtIndex:row];
        
        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:15];
        myView.textColor = [UIColor lightGrayColor];

        myView.backgroundColor = [UIColor clearColor];

    }
    
    else {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 180, 30)];
        
        myView.text = [self.thirdPickerDataSource objectAtIndex:row];
        myView.textColor = [UIColor lightGrayColor];

        myView.textAlignment = NSTextAlignmentCenter;
        
        myView.font = [UIFont systemFontOfSize:15];
        
        myView.backgroundColor = [UIColor clearColor];
        
    }
    
    return myView;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    return 100;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component

{
    
    return 40;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UILabel *labelSelected = (UILabel*)[pickerView viewForRow:row forComponent:component];
    [labelSelected setTextColor:IWGlobalColor];
    if ([self.type isEqualToString:@"BloodPressure"]) {
        if (pickerView.tag == 1) {
            self.text1 = self.firstPickerDataSource[row];
        } else if (pickerView.tag == 2) {
            self.text2 = self.secondPickerDataSource[row];
        } else {
            self.text3 = self.thirdPickerDataSource[row];
        }
    } else {
        if (pickerView.tag == 1) {
            self.text1 = self.firstPickerDataSource[row];
        } else if (pickerView.tag == 2) {
            self.text2 = self.secondPickerDataSource[row];
        } else {
            self.text3 = self.thirdPickerDataSource[row];
        }
    }
    
}


- (UIView *)timeView{
    
    if (_timeView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pickView.frame), IWWIDTH, 60)];
        view.backgroundColor = [UIColor clearColor];
        
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(10, 10, IWWIDTH-20, 40)];
        bgview.backgroundColor = [UIColor whiteColor];
        
        UILabel *timelabel = [[UILabel alloc] init];
        timelabel.frame = CGRectMake(8, 0, 63, 40);
        timelabel.text = @"测量时间";
        timelabel.textAlignment = NSTextAlignmentLeft;
        timelabel.font = [UIFont systemFontOfSize:13];
        timelabel.textColor = [UIColor grayColor];
        [bgview addSubview:timelabel];
        
        UIImageView *imageView =[[UIImageView alloc] init];
        imageView.frame = CGRectMake(CGRectGetMaxX(bgview.frame) - 22, (40-12)/2, 12, 12);
        imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [bgview addSubview:imageView];

        
        UITextField *resultlabel = [[UITextField alloc] init];
        resultlabel.frame = CGRectMake(CGRectGetMaxX(timelabel.frame), 0, (CGRectGetMinX(imageView.frame) - CGRectGetMaxX(timelabel.frame)), 40);
        resultlabel.text = @"请选择测量时间";
        
        resultlabel.textAlignment = NSTextAlignmentRight;
        resultlabel.font = [UIFont systemFontOfSize:12];
        resultlabel.textColor = [UIColor grayColor];
        resultlabel.backgroundColor = [UIColor whiteColor];
        [bgview addSubview:resultlabel];
        self.inputTimeView = resultlabel;
        
        [view addSubview:bgview];
        [self.scrollView addSubview:view];
        _timeView = view;
        
    }
    
    return _timeView;
    
}

- (void)setupTimeView {
    UIDatePicker *beginDatePicker = [self setupDatePicker];
    beginDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
    UIToolbar *beginToolbar = [self toolBar:@selector(showBeginSelectDate)];
    [self.inputTimeView setInputView:beginDatePicker];
    [self.inputTimeView setInputAccessoryView:beginToolbar];
    self.beginDatePicker = beginDatePicker;
}

- (UIToolbar *)toolBar:(SEL)selector {
    UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.barTintColor = [UIColor lightGrayColor];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:selector];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    return toolbar;
}

- (void)showBeginSelectDate {
    self.inputTimeView.text = [self.formatter stringFromDate:self.beginDatePicker.date];
    [self.inputTimeView resignFirstResponder];
    CGPoint offect = self.scrollView.contentOffset;
    offect.y = - self.scrollView.contentInset.top;
    [self.scrollView setContentOffset:offect animated:YES];
    
}

- (UIDatePicker *)setupDatePicker {
    // Add the picker
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDateAndTime;
    pickerView.date = [NSDate date]; // 设置初始时间
    pickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    pickerView.maximumDate = [NSDate date]; // 设置最大时间
    
    return pickerView;
}


- (UIView *)textView{
    
    if (_textView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_timeView.frame), IWWIDTH - 20, 100)];
        view.backgroundColor = [UIColor whiteColor];
    
        IWTextView *textView = [[IWTextView alloc] init];
        textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
        textView.delegate = self;
        textView.frame = view.frame;
        textView.font = [UIFont systemFontOfSize:12];
        textView.placeholder = NSLocalizedString(@"medical_monitor_pressure_content_hit", nil);
        self.inputTextView = textView;

        [self.scrollView addSubview:view];
        [self.scrollView addSubview:textView];
        _textView = view;
    }
    
    return _textView;
}

- (UIButton *)saveButton{

    if (_saveButton == nil) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, CGRectGetMaxY(self.textView.frame) + 20, self.view.frame.size.width - 20, 40);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
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
        
        [self.scrollView addSubview:button];

        _saveButton = button;
    }
    
    
    
    return _saveButton;

    
    
}

- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error{
    if (name == nil || [name isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        return YES;
    }
    return NO;
}

- (void)buttonClicked:(UIButton *)btn
{
    NSString *measureTime = self.inputTimeView.text;
    NSString *desc = self.inputTextView.text;
    
    // 判断
    if ([measureTime isEqualToString:@"请选择测量时间"]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"medical_monitor_pressure_date_empty", nil)];
        return;
    }
    
    
    if ([self.type isEqualToString:@"BloodPressure"]) {
        IWAddMedicalPressureParam *param = [[IWAddMedicalPressureParam alloc] init];
        param.loginId = [IWUserTool user].loginId;
        param.companyId = @(IWCompanyId);
        param.memberId = self.memberId;
        param.highPresure = self.text1;
        param.lowPressure = self.text2;
        param.heartRate = self.text3;
        param.measureTime = measureTime;
        param.remark = [desc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalPressureWithParam:param success:^(IWAddMedicalPressureResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0 && result.datas != nil) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                
                IWPressureAndSugerDetailViewController *vc = [[IWPressureAndSugerDetailViewController alloc] init];
                vc.navigationItem.title = @"血压监测详情";
                vc.isShowresurvey = YES;
                vc.pressureModel = result.datas;
                vc.pressureModel.highPresure = self.text1;
                vc.pressureModel.lowPressure = self.text2;
                vc.pressureModel.heartRate = self.text3;

                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:NSLocalizedString(@"save_fail", nil)];
        }];
    } else {
        IWAddMedicalSugarParam *param = [[IWAddMedicalSugarParam alloc] init];
        param.loginId = [IWUserTool user].loginId;
        param.companyId = @(IWCompanyId);
        param.memberId = self.memberId;
        param.period = self.text1;
        param.bloodSugar = [NSString stringWithFormat:@"%@.%@", self.text2, self.text3];
        param.measureTime = measureTime;
        param.remark = [desc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
        [IWMedicalArchivesTool addMedicalSugerWithParam:param success:^(IWAddMedicalSugarResult *result) {
            [MBProgressHUD hideHUD];
            if (result.code == 0 && result.datas != nil) {
                [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
                
                IWPressureAndSugerDetailViewController *vc = [[IWPressureAndSugerDetailViewController alloc] init];
                vc.navigationItem.title = @"血糖监测详情";
                vc.isShowresurvey = YES;
                vc.sugerModel = result.datas;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                [MBProgressHUD showSuccess:result.info];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:NSLocalizedString(@"save_fail", nil)];
        }];
    }
}

#pragma mark -- TextFieldDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGPoint offect = self.scrollView.contentOffset;
    offect.y = - self.scrollView.contentInset.top;
    [self.scrollView setContentOffset:offect animated:YES];
}

@end
