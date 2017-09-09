//
//  IWInquiryDetailViewController.m
//  Doctor
//
//  Created by 深水区 on 17/1/2.
//
//

#import "IWInquiryDetailViewController.h"
#import "IWProfileArowTableViewCell.h"
#import "IWInquiryTool.h"
#import "IWToast.h"
#import "IWGetInquiryDetailResult.h"
#import "IWMedicalReport.h"
#import "IWTextView.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "IWPhotosView.h"
#import "UzysAssetsPickerController.h"
#import "IWPhoto.h"
#import "IWMedicalReportAddViewController.h"
#import "MJRefreshHeaderView.h"
#import "IWInquiryDetailViewCell.h"
#import "IWGetInquiryDetail.h"
#import "IWMedicalReportViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "IWEvaluateDoctorViewController.h"

#define IWFleaMarketAddMargin 8
#define IWFleaMarketAddPadding 10
#define IWFleaMarketFieldHeight 34

@interface IWInquiryDetailViewController ()<UITableViewDataSource,UITableViewDelegate, MJRefreshBaseViewDelegate, UITextViewDelegate,UzysAssetsPickerControllerDelegate, IWInquiryDetailViewCellDelegate>
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, weak) UILabel *questionlabel;
@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak) UIButton *addImageButton;
@property (nonatomic, weak) UIButton *questionReportButton;
@property (nonatomic, weak) UIButton *submitButton;
@property (nonatomic, weak) UIView *addImageView;
@property (nonatomic, weak) UIView *view3;
@property (nonatomic, copy) NSString *objectName;
@property (nonatomic, copy) NSString *memberID;
@property (nonatomic, weak) UILabel *objectLabel;
@property (nonatomic, weak) UILabel *myDoctorLabel;
@property (nonatomic, weak) IWPhotosView *photosView;
@property (nonatomic, weak) UILabel *addImageText;
@property (nonatomic, weak) UIView *view4;
@property (nonatomic, weak) UIView *reportView;
@property (nonatomic, weak) UIView *footerView;
@property (nonatomic, weak) TPKeyboardAvoidingTableView *tableView;


@property (nonatomic, strong) NSMutableArray *deleteImages;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) NSMutableArray *reports;
@end

@implementation IWInquiryDetailViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置tableView属性
    [self tableView];
    
    // 集成刷新控件
    [self setupRefreshView];
    [self setupQuestionLabel];
    
    [self setupTextView];
    
    [self setupAddimageButton];
    
    [self setupQuestReportButton];
    
    [self setupSubmitButton];
    
    [self addNotice];
}

- (void)addNotice {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(deleteImage:) name:IWImagesDeleteNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 释放内存
    [self.header free];
}
/**
 *  集成刷新控件
 */
- (void)setupRefreshView {
    // 1. 下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    // 自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
}

/**
 *  刷新控件进入开始刷新状态的时候调用
 */
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) { // 下拉刷新
        [self loaddata];
    }
}


- (void)loaddata{
    IWGetInquiryDetailParam *param = [[IWGetInquiryDetailParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.inquiryId = self.inquiry.ID;
    
    [IWInquiryTool inquiryDetailWithParam:param success:^(IWGetInquiryDetailResult *result) {
        // 设置数据
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:result.datas];
        self.datas = tempArray;
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        IWLog(@"%@", error);
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc]init];
        tableView.frame = CGRectMake(0, 0, IWWIDTH, IWHEIGHT- 64);
        tableView.backgroundColor=[UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled=YES;
        tableView.dataSource=self;
        tableView.delegate=self;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:tableView];
        _tableView = tableView;
        
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = IWTableViewBgColor;
        footerView.frame = CGRectMake(0, 0, kWidth, 0);
        self.footerView = footerView;
        tableView.tableFooterView = footerView;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    IWInquiryDetailViewCell *cell = [IWInquiryDetailViewCell cellWithTableView:tableView];
    cell.delegate = self;
    // 2.传递frame模型
    cell.detail = self.datas[indexPath.row];
    
    
    //对医生评价  点击方法
    [cell setEvaluateDoctorButtonBlock:^{
    
        IWEvaluateDoctorViewController *vc = [[IWEvaluateDoctorViewController alloc] init];
        vc.navigationController.title = NSLocalizedString(@"inquiry_doctor_title", nil);
        vc.memberID = self.memberID;
        vc.inquiryId = [self.datas[indexPath.row] ID];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datas[indexPath.row];
    return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"detail" cellClass:[IWInquiryDetailViewCell class] contentViewWidth:[self cellContentViewWith]];
}



- (CGFloat)cellContentViewWith {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)didClickLoadButton:(IWMedicalReport *)report {
    IWMedicalReportAddViewController *add = [[IWMedicalReportAddViewController alloc] init];
    add.memberId = self.memberID;
    add.medicalReportModel = report;
    [self.navigationController pushViewController:add animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)setupQuestionLabel{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(IWFleaMarketAddMargin, IWFleaMarketAddMargin, 100, 40);
    label.font = IWFont;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"追问：";
    [self.footerView addSubview:label];
    self.questionlabel = label;
}


- (void)setupTextView{
    
    IWTextView *textview = [[IWTextView alloc] init];
    textview.frame = CGRectMake(IWFleaMarketAddMargin, CGRectGetMaxY(self.questionlabel.frame), IWWIDTH-2*IWFleaMarketAddMargin, 80);
    textview.backgroundColor=[UIColor whiteColor];
    textview.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textview.delegate = self;
    textview.font = [UIFont systemFontOfSize:12];
    textview.placeholder = @"尽可能的描述自己的身体问题";
    [self.footerView addSubview:textview];
    self.textView =textview;
}


- (void)setupAddimageButton
{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame) + 10, IWWIDTH, 40);
    
    // photosView
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    photosView.noClick = true;
    [view addSubview:photosView];
    self.photosView = photosView;
    
    
    UIView *addPictureView = [[UIView alloc] init];
    addPictureView.backgroundColor = [UIColor clearColor];
    addPictureView.frame = CGRectMake(0, 0, IWWIDTH, 40);
    [view addSubview:addPictureView];
    self.addImageView = addPictureView;
    
    UIButton *button = [[UIButton alloc] init];
    button.width = 60;
    button.height = 40;
    button.y = 0;
    button.x = kWidth - button.width - 2 * IWFleaMarketAddMargin;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    button.backgroundColor = [UIColor clearColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = IWFont;
    [button setTitle:@"添加照片" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addPictureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [addPictureView addSubview:button];
    self.addImageButton = button;
    
    UILabel *label = [[UILabel alloc] init];
    label.font = IWFont;
    label.backgroundColor = [UIColor clearColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentRight;
    label.text = @"(最多可添加6张)";
    label.textColor = [UIColor redColor];
    label.userInteractionEnabled = YES;
    CGFloat labelX = IWFleaMarketAddMargin;
    CGFloat labelY = 0;
    CGFloat labelW = button.x - IWFleaMarketAddMargin;
    CGFloat labelH = button.height;
    label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPictureButtonClicked)];
    [label addGestureRecognizer:gesture];
    
    [addPictureView addSubview:label];
    self.addImageText = label;
    
    [self.footerView addSubview:view];
    self.view3 = view;
    
}

- (void)addPictureButtonClicked{
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
    
    CGFloat photosY = IWFleaMarketAddMargin;
    CGSize photosSize = [IWPhotosView sizeWithPhotosCount:_photosView.pic_urls.count];
    CGFloat photosX = IWFleaMarketAddMargin;
    
    self.photosView.frame = (CGRect){{photosX, photosY}, photosSize};
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
    self.view4.y = CGRectGetMaxY(self.view3.frame);
    if (self.reports != nil) {
        self.reportView.y = CGRectGetMaxY(self.view4.frame) - IWFleaMarketAddMargin;
        self.submitButton.y = CGRectGetMaxY(self.reportView.frame) + 20;
    } else {
        self.submitButton.y = CGRectGetMaxY(self.view4.frame) + 20;
    }
    self.footerView.height = CGRectGetMaxY(self.submitButton.frame) + 20;
    self.tableView.tableFooterView = self.footerView;
}


- (void)setupQuestReportButton
{
    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(0, CGRectGetMaxY(self.view3.frame), IWWIDTH, 40);
    view4.backgroundColor = [UIColor clearColor];
    [self.footerView addSubview:view4];
    self.view4 = view4;
    
    
    UIButton *objectButton = [[UIButton alloc] init];
    objectButton.frame = CGRectMake(IWFleaMarketAddMargin, 0, IWWIDTH - 2 * IWFleaMarketAddMargin , IWFleaMarketFieldHeight);
    objectButton.backgroundColor = [UIColor whiteColor];
    objectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    objectButton.titleEdgeInsets = UIEdgeInsetsMake(0, IWFleaMarketAddMargin, 0, 0);
    objectButton.titleLabel.font = IWFont;
    [objectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [objectButton setTitle:@"问题对应报告" forState:UIControlStateNormal];
    [objectButton addTarget:self action:@selector(questionReportButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:objectButton];
    self.questionReportButton = objectButton;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(IWWIDTH - 10 - 15, CGRectGetMidY(self.questionReportButton.frame) - 6, 12, 12);
    imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
    [view4 addSubview:imageView];
    [self.footerView bringSubviewToFront:imageView];
    
}

- (void)setReports:(NSMutableArray *)reports {
    _reports = reports;
    [self.reportView removeFromSuperview];
    
    UIView *reportView = [[UIView alloc] init];
    reportView.x = IWFleaMarketAddMargin;
    reportView.y = CGRectGetMaxY(self.view4.frame) - IWFleaMarketAddMargin;
    reportView.width = kWidth - 2 * IWFleaMarketAddMargin;
    reportView.backgroundColor = [UIColor whiteColor];
    
    // 设置列表
    int i = 0;
    int height = 26;
    for (IWMedicalReport *report in reports) {
        UIView *view = [[UIView alloc] init];
        view.tag = i;
        view.height = height;
        view.x = 0;
        view.y = i * view.height;
        view.width = kWidth - 2 * IWFleaMarketAddMargin;
        view.backgroundColor = [UIColor whiteColor];
        [self setupReportView:report view:view];
        i++;
        [reportView addSubview:view];
    }
    reportView.height = height * reports.count + 5;
    [self.footerView addSubview:reportView];
    self.reportView = reportView;
    
    self.submitButton.y = CGRectGetMaxY(self.reportView.frame) + 20;
    self.tableView.tableFooterView = self.footerView;
}

- (void)loadDoctorDetail:(UIButton *)sender {
    IWMedicalReport *report = self.reports[sender.tag];
    IWMedicalReportAddViewController *add = [[IWMedicalReportAddViewController alloc] init];
    add.memberId = self.memberID;
    add.medicalReportModel = report;
    [self.navigationController pushViewController:add animated:YES];
}

- (void)setupReportView:(IWMedicalReport *)report view:(UIView *)view {
    // line
    UIView *divider = [[UIView alloc] init];
    divider.alpha = 0.3;
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.frame = CGRectMake(0, 0, view.width, 0.5);
    [view addSubview:divider];
    
    // arrow
    UIImageView *arrowImage = [[UIImageView alloc] init];
    arrowImage.width = 12;
    arrowImage.height = view.height;
    arrowImage.y = 0;
    arrowImage.x = view.width - IWFleaMarketAddMargin - arrowImage.width;
    arrowImage.contentMode = UIViewContentModeCenter;
    arrowImage.image = [UIImage imageWithName:@"common_icon_arrow"];
    [view addSubview:arrowImage];
    
    // text
    UIButton *label = [[UIButton alloc] init];
    label.tag = view.tag;
    label.titleLabel.font = [UIFont systemFontOfSize:11];
    [label setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [label setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [label setTitle:[NSString stringWithFormat:@"%@ %@", report.reportDate, report.reportType2show] forState:UIControlStateNormal];
    label.x = IWFleaMarketAddMargin;
    label.y = 0;
    label.height = view.height;
    label.width = CGRectGetMinX(arrowImage.frame) - IWFleaMarketAddMargin;
    [label addTarget:self action:@selector(loadDoctorDetail:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:label];
}

- (void)questionReportButtonClicked {
    IWMedicalReportViewController *vc = [[IWMedicalReportViewController alloc] init];
    IWGetInquiryDetail *detail = self.datas[0];
    vc.memberId = detail.memberId;
    vc.isFromInquiry = YES;
    vc.reports = self.reports;
    [vc setFromeControllerBlock:^(NSMutableArray *reports) {
        self.reports = reports;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupSubmitButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, CGRectGetMaxY(self.view4.frame) + 20, IWWIDTH - 20, 34);
    [button addTarget:self action:@selector(savebuttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 6;
    
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
    
    [self.footerView addSubview:button];
    self.submitButton = button;
    self.footerView.height = CGRectGetMaxY(self.submitButton.frame) + 20;
}

- (void)savebuttonClicked{
    NSString *remark = self.textView.text;
    
    if (remark == nil || [remark isEqualToString:@""]) {
        [IWToast toastWithView:self.view title:@"请填写描述内容"];
        return;
    }
    
    IWAddInquiryParam *param = [[IWAddInquiryParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    param.memberId = self.memberID;
    
    if (self.reports != nil) {
        param.reportId = [[self.reports valueForKey:@"ID"] componentsJoinedByString:@","];
    }
    
    param.inquiryType = self.inquiry.inquiryType;
    param.inquiryId = self.inquiry.ID;
    param.remark = [remark stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *datas = self.photosView.datas;;
    
    [MBProgressHUD showMessage:NSLocalizedString(@"save_loading", nil)];
    [IWInquiryTool submitInquiryWithParams:param datas:datas success:^(IWBaseResult *result) {
        [MBProgressHUD hideHUD];
        if (result.code == 0) {
            [MBProgressHUD showSuccess:NSLocalizedString(@"save_success", nil)];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBProgressHUD showSuccess:result.info];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:NSLocalizedString(@"save_fail", nil)];
    }];
}

@end
