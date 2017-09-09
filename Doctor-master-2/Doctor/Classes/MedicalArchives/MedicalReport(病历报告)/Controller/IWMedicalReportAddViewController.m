//
//  IWMedicalReportAddViewController.m
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import "IWMedicalReportAddViewController.h"
#import "IWButtonTableViewCell.h"
#import "IWTextFieldTableViewCell.h"
#import "IWAddReportFooterView.h"
#import "UzysAssetsPickerController.h"
#import "IWPhoto.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "IWTextField.h"
#import "IWTextView.h"
#import "IWToast.h"
#import "IWMedicalArchivesTool.h"
#import "IWMedicalReport.h"

#define IWFleaMarketAddMargin 8
#define IWFleaMarketAddPadding 5
#define IWFleaMarketFieldHeight 26

@interface IWMedicalReportAddViewController ()<UzysAssetsPickerControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, weak) TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UILabel *typeLabelTip;
@property (nonatomic, weak) UIButton *typeButton;
@property (nonatomic, weak) UILabel *dateTip;
@property (nonatomic, weak) UITextField *inputDate;
@property (nonatomic, weak) UILabel *oranLabelTip;
@property (nonatomic, weak) UITextField *inputOran;
@property (nonatomic, weak) UILabel *nameLabelTip;
@property (nonatomic, weak) UITextField *inputName;

@property (nonatomic, weak) UIView *view2;
@property (nonatomic, weak) IWTextView *descField;

@property (nonatomic, weak) UIView *view3;
@property (nonatomic, weak) IWPhotosView *photosView;
@property (nonatomic, weak) UIView *addImageView;
@property (nonatomic, weak) UIButton *addImageButton;
@property (nonatomic, weak) UILabel *addImageText;

@property (nonatomic, weak) UIButton *submitButton;

@property (nonatomic, strong) NSMutableArray *types;

@property (nonatomic, strong) NSMutableArray *deleteImages;
@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation IWMedicalReportAddViewController

- (NSMutableArray *)deleteImages {
    if (_deleteImages == nil) {
        _deleteImages = [NSMutableArray array];
    }
    return _deleteImages;
}

- (NSMutableArray *)images {
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (NSMutableArray *)types {
    if (_types == nil) {
        _types = [NSMutableArray array];
        [_types addObject:NSLocalizedString(@"medical_report_type1", nil)];
        [_types addObject:NSLocalizedString(@"medical_report_type2", nil)];
        [_types addObject:NSLocalizedString(@"medical_report_type3", nil)];
        [_types addObject:NSLocalizedString(@"medical_report_type4", nil)];
    }
    return _types;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBase];
    [self setupViews];
    
    if (self.medicalReportModel != nil) {
        [self loadDetail];
    }
    // 监听
    [self addNotice];
}

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(deleteImage:) name:IWImagesDeleteNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadDetail {
    IWGetMedicalReportDetailParam *param = [[IWGetMedicalReportDetailParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    if (self.medicalReportModel.reportId != nil && ![self.medicalReportModel.reportId isEqualToString:@""]){
        param.reportId = self.medicalReportModel.reportId;
    } else {
        param.reportId = self.medicalReportModel.ID;
    }
    
    [MBProgressHUD showMessage:NSLocalizedString(@"loading", nil)];
    [IWMedicalArchivesTool medicalReportDetailWithParam:param success:^(IWGetMedicalReportDetailResult *result) {
        // 隐藏加载框
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            // 设置数据
            [self setupData:result.datas];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
    } failure:^(NSError *error) {
        // 关闭loading
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)setupData:(IWMedicalReport *)medicalReport {
    [self.typeButton setTitle:medicalReport.reportType2show forState:UIControlStateNormal];
    self.inputDate.text = medicalReport.reportDate;
    self.inputOran.text = medicalReport.hospital;
    self.inputName.text = medicalReport.disease;
    self.descField.text = medicalReport.remark;
    
    self.images = [medicalReport urlsWithEdit:YES];
    [self setupImage];
}

- (void)setupBase {
    self.title = NSLocalizedString(@"medical_report_add_title", nil);
    self.view.backgroundColor = IWTableViewBgColor;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.formatter = formatter;
}

- (void)setupViews {
    // 添加控件
    // ScrollView
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    scrollView.x = 0;
    scrollView.y = 0;
    scrollView.backgroundColor = IWTableViewBgColor;
    scrollView.width = [UIScreen mainScreen].bounds.size.width;
    scrollView.height = [UIScreen mainScreen].bounds.size.height;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    [self setupView1];
    [self setupView2];
    [self setupView3];
    
    // submitButton
    UIButton *submitButton = [self setupButton];
    submitButton.centerX = self.scrollView.width * 0.5;
    submitButton.y = CGRectGetMaxY(self.view3.frame) + IWFleaMarketAddMargin;
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitButton];
    self.submitButton = submitButton;
    
    // scrollview
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, CGRectGetMaxY(self.submitButton.frame) + self.submitButton.frame.size.height + 84);
}

- (void)setupView1 {
    // view1
    UIView *view1 = [[UIView alloc] init];
    view1.x = IWFleaMarketAddMargin;
    view1.y = IWFleaMarketAddMargin;
    view1.width = self.scrollView.width - 2 * IWFleaMarketAddMargin;
    view1.backgroundColor = [UIColor whiteColor];
    
    // type tip
    UILabel *typeLabelTip = [self setupLabelTip:NSLocalizedString(@"medical_report_add_type", nil) y:IWFleaMarketAddPadding];
    [view1 addSubview:typeLabelTip];
    self.typeLabelTip = typeLabelTip;
    
    // type button
    UIButton *typeButton = [[UIButton alloc] init];
    typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    CGFloat arrowWith = 12;
    typeButton.x = CGRectGetMaxX(self.typeLabelTip.frame);
    typeButton.width = view1.width - typeButton.x - arrowWith - IWFleaMarketAddMargin;
    typeButton.height = IWFleaMarketFieldHeight;
    typeButton.centerY = self.typeLabelTip.centerY;
    [typeButton setTitle:NSLocalizedString(@"medical_report_add_select_tip", nil) forState:UIControlStateNormal];
    [typeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [typeButton addTarget:self action:@selector(typeClick) forControlEvents:UIControlEventTouchUpInside];
    typeButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:typeButton];
    self.typeButton = typeButton;
    
    // arrow
    UIImageView *arrow1 = [[UIImageView alloc] init];
    arrow1.image = [UIImage imageWithName:@"common_icon_arrow"];
    arrow1.width = arrowWith;
    arrow1.height = arrowWith;
    arrow1.x = CGRectGetMaxX(self.typeButton.frame);
    arrow1.centerY = self.typeButton.centerY;
    [view1 addSubview:arrow1];
    
    // line
    UIView *divider = [[UIView alloc] init];
    divider.frame = CGRectMake(0, CGRectGetMaxY(self.typeButton.frame) + IWFleaMarketAddPadding, view1.width, 0.5);
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [view1 addSubview:divider];
    
    // date tip
    UILabel *dateTip = [self setupLabelTip:NSLocalizedString(@"medical_report_add_date", nil) y:CGRectGetMaxY(divider.frame) + IWFleaMarketAddPadding];
    [view1 addSubview:dateTip];
    self.dateTip = dateTip;
    
    // date
    UITextField *inputDate = [[UITextField alloc] init];
    inputDate.x = CGRectGetMaxX(dateTip.frame);
    inputDate.width = view1.width - inputDate.x - arrowWith - IWFleaMarketAddMargin;
    inputDate.height = IWFleaMarketFieldHeight;
    inputDate.centerY = self.dateTip.centerY;
    inputDate.font = [UIFont systemFontOfSize:12];
    inputDate.textColor = [UIColor darkGrayColor];
    inputDate.textAlignment = NSTextAlignmentRight;
    inputDate.placeholder = NSLocalizedString(@"medical_report_add_select_tip", nil);
    [view1 addSubview:inputDate];
    self.inputDate = inputDate;
    
    UIDatePicker *datePicker = [self setupDatePicker];
    UIToolbar *toolbar = [self toolBar:@selector(showSelectDate)];
    [self.inputDate setInputView:datePicker];
    [self.inputDate setInputAccessoryView:toolbar];
    self.datePicker = datePicker;
    
    // arrow
    UIImageView *arrow2 = [[UIImageView alloc] init];
    arrow2.image = [UIImage imageWithName:@"common_icon_arrow"];
    arrow2.width = arrowWith;
    arrow2.height = arrowWith;
    arrow2.x = CGRectGetMaxX(self.inputDate.frame);
    arrow2.centerY = self.inputDate.centerY;
    [view1 addSubview:arrow2];
    
    // line
    UIView *divider2 = [[UIView alloc] init];
    divider2.frame = CGRectMake(0, CGRectGetMaxY(self.inputDate.frame) + IWFleaMarketAddPadding, view1.width, 0.5);
    divider2.backgroundColor = [UIColor lightGrayColor];
    divider2.alpha = 0.2;
    [view1 addSubview:divider2];
    
    // oran tip
    UILabel *oranLabelTip = [self setupLabelTip:NSLocalizedString(@"medical_report_add_oran", nil) y:CGRectGetMaxY(divider2.frame) + IWFleaMarketAddPadding];
    [view1 addSubview:oranLabelTip];
    self.oranLabelTip = oranLabelTip;
    
    // oran
    UITextField *inputOran = [self setupTextField:NSLocalizedString(@"medical_report_add_tip", nil) x:CGRectGetMaxX(oranLabelTip.frame) centerY:oranLabelTip.centerY];
    [view1 addSubview:inputOran];
    self.inputOran = inputOran;
    
    // line
    UIView *divider3 = [[UIView alloc] init];
    divider3.frame = CGRectMake(0, CGRectGetMaxY(self.inputOran.frame) + IWFleaMarketAddPadding, view1.width, 0.5);
    divider3.backgroundColor = [UIColor lightGrayColor];
    divider3.alpha = 0.2;
    [view1 addSubview:divider3];
    
    // oran tip
    UILabel *nameLabelTip = [self setupLabelTip:NSLocalizedString(@"medical_report_add_name", nil) y:CGRectGetMaxY(divider3.frame) + IWFleaMarketAddPadding];
    [view1 addSubview:nameLabelTip];
    self.nameLabelTip = nameLabelTip;
    
    // name
    UITextField *inputName = [self setupTextField:NSLocalizedString(@"medical_report_add_tip", nil) x:CGRectGetMaxX(nameLabelTip.frame) centerY:nameLabelTip.centerY];
    [view1 addSubview:inputName];
    self.inputName = inputName;
    
    view1.height = CGRectGetMaxY(self.inputName.frame) + IWFleaMarketAddMargin;
    [self.scrollView addSubview:view1];
    self.view1 = view1;
}

- (void)setupView2 {
    // view2
    UIView *view2 = [[UIView alloc] init];
    view2.x = IWFleaMarketAddMargin;
    view2.y = CGRectGetMaxY(self.view1.frame) + IWFleaMarketAddMargin;
    view2.width = self.scrollView.width - 2 * IWFleaMarketAddMargin;
    view2.backgroundColor = [UIColor whiteColor];
    
    // desc
    IWTextView *descField = [[IWTextView alloc] init];
    descField.font = [UIFont systemFontOfSize:12];
    descField.textColor = [UIColor grayColor];
    descField.placeholder = NSLocalizedString(@"medical_report_add_content_tip", nil);
    descField.x = IWFleaMarketAddMargin;
    descField.y = IWFleaMarketAddMargin;
    descField.width = view2.width - 2 * IWFleaMarketAddMargin;
    descField.height = 120;
    [view2 addSubview:descField];
    self.descField = descField;
    
    
    view2.height = CGRectGetMaxY(descField.frame) + IWFleaMarketAddMargin;
    [self.scrollView addSubview:view2];
    self.view2 = view2;
}

- (void)setupView3 {
    // view2
    UIView *view3 = [[UIView alloc] init];
    view3.x = IWFleaMarketAddMargin;
    view3.y = CGRectGetMaxY(self.view2.frame);
    view3.width = self.scrollView.width - 2 * IWFleaMarketAddMargin;
    view3.backgroundColor = [UIColor whiteColor];
    
    // photosView
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    photosView.noClick = true;
    [view3 addSubview:photosView];
    self.photosView = photosView;
    
    // addImageView
    UIView *addImageView = [[UIView alloc] init];
    addImageView.x = IWFleaMarketAddMargin;
    addImageView.y = IWFleaMarketAddPadding;
    addImageView.width = view3.width;
    addImageView.height = 50;
    self.addImageView = addImageView;
    [view3 addSubview:addImageView];
    
    UIButton *addImageButton = [[UIButton alloc] init];
    [addImageButton setImage:[UIImage imageWithName:@"pic_normal"] forState:UIControlStateNormal];
    [addImageButton setImage:[UIImage imageWithName:@"pic_press"] forState:UIControlStateHighlighted];
    addImageButton.x = 0;
    addImageButton.width = 50;
    addImageButton.height = self.addImageView.height;
    [addImageButton addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    [addImageButton setContentMode:UIViewContentModeCenter];
    [self.addImageView addSubview:addImageButton];
    self.addImageButton = addImageButton;
    
    UILabel *addImageText = [[UILabel alloc] init];
    addImageText.font = [UIFont systemFontOfSize:12];
    addImageText.textColor = [UIColor grayColor];
    addImageText.width = 200;
    addImageText.height = self.addImageView.height;
    addImageText.text = NSLocalizedString(@"flea_market_add_image", nil);
    addImageText.x = CGRectGetMaxX(self.addImageButton.frame) + IWFleaMarketAddMargin;
    addImageText.y = 0;
    addImageText.contentMode = UIViewContentModeCenter;
    [self.addImageView addSubview:addImageText];
    self.addImageText = addImageText;
    
    view3.height = CGRectGetMaxY(addImageView.frame) + IWFleaMarketAddMargin;
    [self.scrollView addSubview:view3];
    self.view3 = view3;
}

- (UITextField *)setupTextField:(NSString *)placeHolder x:(CGFloat)x centerY:(CGFloat)centerY {
    UITextField *textField = [[UITextField alloc] init];
    textField.x = x;
    textField.width = self.scrollView.width - 3 * IWFleaMarketAddMargin - self.inputDate.x - 12;
    textField.height = IWFleaMarketFieldHeight;
    textField.centerY = centerY;
    textField.font = [UIFont systemFontOfSize:12];
    textField.textColor = [UIColor darkGrayColor];
    textField.textAlignment = NSTextAlignmentRight;
    textField.placeholder = placeHolder;
    return textField;
}

- (UIButton *)setupButton {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"btn_green"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImageWithName:@"btn_green_highlighted"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:NSLocalizedString(@"doctor_save", nil) forState:UIControlStateNormal];
    button.width = self.scrollView.width - 2 * IWFleaMarketAddMargin;
    button.height = 32;
    return button;
}

- (UILabel *)setupLabelTip:(NSString *)text y:(CGFloat)y {
    UILabel *labelTip = [[UILabel alloc] init];
    labelTip.font = [UIFont systemFontOfSize:13];
    labelTip.textColor = [UIColor blackColor];
    labelTip.text = text;
    labelTip.x = IWFleaMarketAddPadding;
    labelTip.y = y;
    labelTip.width = 70;
    labelTip.height = IWFleaMarketFieldHeight;
    return labelTip;
}

- (void)showSelectDate {
    self.inputDate.text = [self.formatter stringFromDate:self.datePicker.date];
    [self.inputDate resignFirstResponder];
}


- (UIDatePicker *)setupDatePicker {
    // Add the picker
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDate;
    pickerView.date = [NSDate date]; // 设置初始时间
    pickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
    pickerView.maximumDate = [NSDate date];
    //    pickerView.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
    //    pickerView.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
    
    return pickerView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.typeButton setTitle:self.types[buttonIndex] forState:UIControlStateNormal];
}

- (void)typeClick {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"medical_report_add_type", nil) message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:self.types[0], self.types[1], self.types[2], self.types[3], nil];
    [alertView show];
}

- (UIToolbar *)toolBar:(SEL)selector {
    UIToolbar *toolbar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    toolbar.barTintColor = [UIColor lightGrayColor];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:selector];
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    return toolbar;
}

- (void)addImage {
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionVideo = 0;
    picker.maximumNumberOfSelectionPhoto = 6 - self.images.count;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    IWLog(@"assets %@",assets);
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) {
        // Photo
        NSInteger count = assets.count;
        NSMutableArray *array = [NSMutableArray array];
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            IWPhoto *photo = [[IWPhoto alloc] init];
            photo.pic = representation.defaultRepresentation.url.absoluteString;
            photo.asset = representation;
            photo.showDelete = YES;
            [array addObject:photo];
            [self.images addObject:photo];
        }];
        
        [self setupImage];
    }
}

- (void)setupImage {
    NSInteger count = self.images.count;
    // 判断
    if (count == 6) {
        self.addImageView.hidden = YES;
        self.photosView.hidden = NO;
    } else if (count == 0) {
        self.addImageView.hidden = NO;
        self.photosView.hidden = YES;
        self.addImageText.text = NSLocalizedString(@"flea_market_add_image", nil);
    } else {
        self.addImageView.hidden = NO;
        self.photosView.hidden = NO;
        self.addImageText.text = NSLocalizedString(@"flea_market_continue_image", nil);
    }
    
    self.photosView.pic_urls = self.images;
    
    CGFloat photosX = self.addImageView.x;
    CGFloat photosY = IWFleaMarketAddMargin;
    CGSize photosSize = [IWPhotosView sizeWithPhotosCount:_photosView.pic_urls.count];
    self.photosView.frame = (CGRect){{photosX, photosY}, photosSize};
    IWLog(@"%@", NSStringFromCGRect(self.photosView.frame));
    // 设置尺寸
    [self resizeSize];
}

- (void)deleteImage:(NSNotification *)notification {
    NSString *url = notification.userInfo[IWImagesDeleteNotificationPic];
    IWLog(@"url:%@", url);
    NSMutableArray *tempImages = [NSMutableArray array];
    for (IWPhoto *photo in self.images) {
        if ([photo.pic isEqualToString:url]) {
            [self.deleteImages addObject:url];
        } else {
            [tempImages addObject:photo];
        }
    }
    self.images = tempImages;
    
    // 设置数据
    [self setupImage];
}

// 设置尺寸
- (void)resizeSize {
    if (self.addImageView.isHidden) {
        self.addImageView.y = -1000;
        self.view3.height = CGRectGetMaxY(self.photosView.frame)  + IWFleaMarketAddMargin;
    } else {
        self.addImageView.y = CGRectGetMaxY(self.photosView.frame) + IWFleaMarketAddMargin;
        self.view3.height = CGRectGetMaxY(self.addImageView.frame)  + IWFleaMarketAddMargin;
    }
    IWLog(@"%@", NSStringFromCGRect(self.addImageView.frame));
    self.submitButton.y = CGRectGetMaxY(self.view3.frame) + IWFleaMarketAddMargin;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, CGRectGetMaxY(self.submitButton.frame) + self.submitButton.frame.size.height + 84);
}

- (NSString *)getDeleteImages {
    NSMutableString *ns = [NSMutableString string];
    if (self.deleteImages != nil && self.deleteImages.count > 0) {
        for (int i = 0; i < self.deleteImages.count; i++) {
            NSString *url = self.deleteImages[i];
            [ns appendString:url];
            if (self.deleteImages.count - 1 == i) {
                break;
            }
            [ns appendString:@","];
        }
    }
    return [NSString stringWithString:ns];
}

- (void)submit {
    NSString *type = self.typeButton.titleLabel.text;
    NSString *date = self.inputDate.text;
    NSString *oran = self.inputOran.text;
    NSString *name = self.inputName.text;
    NSString *desc = self.descField.text;
    
    // 判断标题
    if ([type isEqualToString:NSLocalizedString(@"medical_report_add_select_tip", nil)]) {
         [IWToast toastWithView:self.view title:NSLocalizedString(@"please_input_report_type", nil)];
        return;
    }
    if ([self checkValideWithName:type error:@"please_input_report_type"]) return;
    if ([self checkValideWithName:date error:@"please_input_report_date"]) return;
    if ([self checkValideWithName:oran error:@"please_input_report_hosptial"]) return;
    if ([self checkValideWithName:name error:@"please_input_report_name"]) return;
    
    
    IWAddReportParam *param = [[IWAddReportParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.memberId = self.memberId;
    param.reportType = [self.types indexOfObject:type];
    param.reportDate = date;
    param.hospital = [oran stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    param.disease = [name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    param.remark = [desc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    param.deletePic = [self getDeleteImages];
    
    NSArray *datas = self.photosView.datas;
    [MBProgressHUD showMessage:NSLocalizedString(@"question_updata_now", nil)];
    
    [IWMedicalArchivesTool submitReportWithParams:param datas:datas success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"doctor_toast_success", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:NSLocalizedString(@"send_fail", nil)];
    }];
}

/**
 *  检查输入字符的合法性
 *
 *  @param name  输入字符
 *  @param error 错误显示
 *
 *  @return true：非法
 */
- (BOOL)checkValideWithName:(NSString *)name error:(NSString *)error{
    if (name == nil || [name isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:NSLocalizedString(error, nil)];
        return YES;
    }
    return NO;
}

@end
