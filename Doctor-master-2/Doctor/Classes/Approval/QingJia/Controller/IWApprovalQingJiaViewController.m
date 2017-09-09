//
//  IWApprovalQingJiaViewController.m
//  Conedot
//
//  Created by 范超 on 15/9/16.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWApprovalQingJiaViewController.h"
#import "IWToast.h"
#import "IWFanCompany.h"
#import "MBProgressHUD+MJ.h"
#import "UzysAssetsPickerController.h"



@interface IWApprovalQingJiaViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewBase;
@property (weak, nonatomic) IBOutlet UIButton *inputType;
@property (weak, nonatomic) IBOutlet UITextField *inputTimeBegin;
@property (weak, nonatomic) IBOutlet UITextField *inputTimeEnd;
@property (weak, nonatomic) IBOutlet UITextField *inputTimeTotalDay;
@property (weak, nonatomic) IBOutlet UITextField *inputTimeTotalHour;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddFile;
@property (weak, nonatomic) IBOutlet UITextField *inputReason;
@property (weak, nonatomic) IBOutlet UIButton *inputReview;
@property (weak, nonatomic) IBOutlet UIButton *inputCopy;
@property (weak, nonatomic) IBOutlet UIButton *buttonSubmit;
@property (weak, nonatomic) IBOutlet UIView *viewMiddle;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@property (nonatomic, weak) UIDatePicker *beginDatePicker;
@property (nonatomic, weak) UIDatePicker *endDatePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;

- (IBAction)showType;
- (IBAction)showReview:(UIButton *)sender;
- (IBAction)addFile:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@property (nonatomic, strong) NSMutableArray *leaveTypes;

@end

@implementation IWApprovalQingJiaViewController


- (NSMutableArray *)leaveTypes {
    if (_leaveTypes == nil) {
        _leaveTypes = [NSMutableArray array];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_1", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_2", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_3", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_4", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_5", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_6", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_7", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_8", nil)];
        [_leaveTypes addObject:NSLocalizedString(@"leaves_type_9", nil)];
    }
    return _leaveTypes;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置基本
    [self setupBase];
    [self setupBaseView];
    [self setupTimeView];
}

- (void)setupTimeView {
    UIDatePicker *beginDatePicker = [self setupDatePicker];
    UIToolbar *beginToolbar = [self toolBar:@selector(showBeginSelectDate)];
    [self.inputTimeBegin setInputView:beginDatePicker];
    [self.inputTimeBegin setInputAccessoryView:beginToolbar];
    self.beginDatePicker = beginDatePicker;
    
    UIDatePicker *endDatePicker = [self setupDatePicker];
    UIToolbar *endToolbar = [self toolBar:@selector(showEndSelectDate)];
    [self.inputTimeEnd setInputView:endDatePicker];
    [self.inputTimeEnd setInputAccessoryView:endToolbar];
    self.endDatePicker = endDatePicker;
}

- (void)setupBaseView {
    self.scrollView = (TPKeyboardAvoidingScrollView *)self.scrollViewBase;
    self.button = self.buttonSubmit;
    self.addFile = self.buttonAddFile;
    self.bottom = self.viewBottom;
    self.textFieldReview = self.inputReview;
    self.textFieldCopy = self.inputCopy;
    [self.viewMiddle addSubview:self.photosView];
}

- (void)setupBase {
    self.title = NSLocalizedString(@"approval_qingjia_title", nil);
    self.view.backgroundColor = IWTableViewBgColor;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.formatter = formatter;
}

- (void)showBeginSelectDate {
    self.inputTimeBegin.text = [self.formatter stringFromDate:self.beginDatePicker.date];
    [self.inputTimeBegin resignFirstResponder];
}

- (void)showEndSelectDate {
    self.inputTimeEnd.text = [self.formatter stringFromDate:self.endDatePicker.date];
    [self.inputTimeEnd resignFirstResponder];
}

- (UIToolbar *)toolBar:(SEL)selector {
    UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.barTintColor = [UIColor lightGrayColor];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:selector];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];

    return toolbar;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.inputType setTitle:self.leaveTypes[buttonIndex] forState:UIControlStateNormal];
}

- (IBAction)showType {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"approval_qingjia_type", nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:self.leaveTypes[0], self.leaveTypes[1], self.leaveTypes[2], self.leaveTypes[3], self.leaveTypes[4], self.leaveTypes[5], self.leaveTypes[6], self.leaveTypes[7], self.leaveTypes[8], nil];
    [alertView show];
}

- (IBAction)showReview:(UIButton *)sender {
    self.currentView = sender;
    [self loadDepartmentData:self.company];
}

- (IBAction)addFile:(UIButton *)sender {
    [self addImage];
}


// 设置尺寸
- (void)resizeSize {
    if (self.photosView.isHidden) {
        self.viewMiddle.height = CGRectGetMaxY(self.buttonAddFile.frame);
    } else {
        self.viewMiddle.height = CGRectGetMaxY(self.photosView.frame) + IWApprovalAddMargin;
    }

    self.viewBottom.y = CGRectGetMaxY(self.viewMiddle.frame) + IWApprovalAddMargin;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, CGRectGetMaxY(self.viewBottom.frame) + self.viewBottom.frame.size.height);
    IWLog(@"%@----", NSStringFromCGRect(self.scrollView.frame));
}


- (IBAction)submit:(UIButton *)sender {
    NSString *type = self.inputType.titleLabel.text;
    NSString *timeBegin = self.inputTimeBegin.text;
    NSString *timeEnd = self.inputTimeEnd.text;
    NSString *timeTotalDay = self.inputTimeTotalDay.text;
    NSString *timeTotalHour = self.inputTimeTotalHour.text;
    NSString *reason = self.inputReason.text;
    NSString *review = self.inputReview.titleLabel.text;
    NSString *copy = self.inputCopy.titleLabel.text;
    
    // 判断
    if ([self checkMustName:type error:@"approval_qingjia_type_error"]) return;
    if ([self checkValideWithName:timeBegin error:@"approval_qingjia_time_error"]) return;
    if ([self checkValideWithName:timeEnd error:@"approval_qingjia_time_error"]) return;
    NSDate *d1 = [self.formatter dateFromString:timeBegin];
    NSDate *d2 = [self.formatter dateFromString:timeEnd];
    long diff = d2.timeIntervalSince1970 - d1.timeIntervalSince1970;
    if (diff <= 0) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"approval_qingjia_end_over_start_error", nil)];
        return;
    }
    if (([timeTotalDay isEqualToString:@""] && [timeTotalHour isEqualToString:@""])
        || ([@"0" isEqualToString:timeTotalDay] && [@"0"isEqualToString:timeTotalHour])) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"approval_qingjia_time_total_error", nil)];
        return;
    }
    if ([self checkValideWithName:reason error:@"approval_qingjia_reason_error"]) return;
    if ([self checkMustName:review error:@"approval_qingjia_review_error"]) return;
    

}


@end
