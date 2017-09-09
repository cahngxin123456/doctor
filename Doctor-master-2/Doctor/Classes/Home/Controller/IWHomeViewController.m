//
//  IWHomeViewController.m
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWHomeViewController.h"
#import "IWHealthFileViewController.h"
#import "IWScrollHeaderView.h"
#import "IWHomeTool.h"
#import "IWNavigationController.h"
#import "IWBanner.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWCompanyTool.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Masonry.h"
#import "IWTrainningViewController.h"
#import "IWDoctorSignViewController.h"
#import "IWNppViewController.h"
#import "IWWebViewController.h"
#import "IWCompanyDetailViewController.h"
#import "IWPicAndTextMessageDiagnoseController.h"
#import "ScanViewController.h"
#import "IWProfileInfoViewController.h"
#import "IWMyDoctorViewController.h"
#import "IWRemind.h"

@interface IWHomeViewController () <IWScrollHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;

@property (weak, nonatomic) IBOutlet UILabel *labelBloodPressure;
@property (weak, nonatomic) IBOutlet UILabel *labelBloodSugar;
@property (weak, nonatomic) IBOutlet UILabel *labelnewReply;

@property (weak, nonatomic) IBOutlet UILabel *labelBloodPressureTip;
@property (weak, nonatomic) IBOutlet UILabel *labelBloodSugarTip;
@property (weak, nonatomic) IBOutlet UILabel *labelnewReplyTip;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UILabel *middleLabelView;

@property (nonatomic, weak) IWScrollHeaderView *scrollHeaderView;

- (IBAction)loadMedicalArchives:(UIButton *)sender;
- (IBAction)loadTrainning:(UIButton *)sender;
- (IBAction)loadDoctorSign:(UIButton *)sender;
- (IBAction)loadNnpList:(UIButton *)sender;
- (IBAction)loadInquiry;
- (IBAction)loadMyDoctor:(UIButton *)sender;

@end

@implementation IWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置基本属性
    [self setupBase];
    
    [self setupView];
    
    // 设置右边的item
    UIBarButtonItem *scan = [[UIBarButtonItem alloc] initWithImage:[UIImage resizedImageWithName:@"scan"] style:UIBarButtonItemStyleDone target:self action:@selector(scan:)];
    
    self.navigationItem.rightBarButtonItems = @[scan];
}

- (void)setupView {
    [self setupRadius:self.view1];
    [self setupRadius:self.view2];
    [self setupRadius:self.view3];
    [self setupRadius:self.view4];
    [self setupRadius:self.view5];
    [self setupRadius:self.view6];
}

- (void)setupRadius:(UIView *)view {
    view.layer.cornerRadius = 6;
    view.clipsToBounds = YES;
}

- (void)getRemindMessage {
    IWRemindParam *param = [[IWRemindParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    
    [IWHomeTool remindNumberWithParam:param success:^(IWRemindResult *result) {
        // 设置公司的未读数
        IWRemind *remind = result.datas;
        if (remind == nil) {
            return;
        }
        [self setupRemind:remind];
    } failure:^(NSError *error) {
    }];
}

- (void)setupRemind:(IWRemind *)remind {
    self.labelBloodPressure.text = [NSString stringWithFormat:@"%@", remind.todayBloodPressure];
    self.labelBloodSugar.text = [NSString stringWithFormat:@"%@", remind.todayBloodSugar];
    self.labelnewReply.text = [NSString stringWithFormat:@"%@", remind.rnewReply];
}

- (void)scan:(UIBarButtonItem *)item {
    ScanViewController *vc = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]] || [child isKindOfClass:[UIImageView class]]) {
            [child removeFromSuperview];
        }
    }
    [self setupBase];
    
    // 监听通知
    [self addNotice];
    
    // 加载banner
    [self setupBannerData];
    
    // 加载remind
    [self getRemindMessage];
}

- (void)setupBase {
    self.navigationItem.title = NSLocalizedString(@"family_doctor", nil);
    self.view.backgroundColor = IWTableViewBgColor;
    
    // 设置banner
    IWScrollHeaderView *scrollhHeaderView = [IWScrollHeaderView headerView];
    scrollhHeaderView.delegate = self;
    [self.view addSubview:scrollhHeaderView];
    self.scrollHeaderView = scrollhHeaderView;
    [self setupDefaultBanner];
    
    // 中间的view
     self.middleView.transform =  CGAffineTransformMakeRotation(45 * M_PI / 180);
     self.middleImageView.transform =  CGAffineTransformMakeRotation(-45 * M_PI / 180);
     self.middleLabelView.transform =  CGAffineTransformMakeRotation(-45 * M_PI / 180);
    
    // 点击事件
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadMedicalArchives)];
    [self.labelBloodPressureTip addGestureRecognizer:gesture];
    [self.labelBloodSugarTip addGestureRecognizer:gesture];
    
    UITapGestureRecognizer *gesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadInquiry)];
    [self.labelnewReplyTip addGestureRecognizer:gesture1];
}

/**
 *  监听通知
 */
- (void)addNotice {
    [IWNotificationCenter addObserver:self selector:@selector(bannerClick:) name:IWHomeClickNotification object:nil];
    [IWNotificationCenter addObserver:self selector:@selector(loadChangeUserUI) name:IWLoadUserUINotification object:nil];
}

- (void)dealloc {
    [IWNotificationCenter removeObserver:self];
}

- (void)loadChangeUserUI {
    IWProfileInfoViewController *vc = [[IWProfileInfoViewController alloc] init];
    vc.isFromMine = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bannerClick:(NSNotification *)note {
    IWBanner *banner = note.userInfo[IWHomeClickNotificationBanner];
    [self headerViewTapWithBanner:banner];
}

- (void)setupDefaultBanner {
    NSMutableArray *datas = [NSMutableArray array];
    IWBanner *banner = [[IWBanner alloc] init];
    banner.defaultId = @"banner_default";
    [datas addObject:banner];
    self.scrollHeaderView.newses = datas;
}

- (void)headerViewTapWithBanner:(IWBanner *)banner {
    // 进入详情页面
    NSString *type = banner.objectType;
    if ([@"news" isEqualToString:type]) {
        // news
        IWCompanyDetailViewController *vc = [[IWCompanyDetailViewController alloc] init];
        vc.newsId = banner.objectId;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([@"policy" isEqualToString:type]) {
        // policy
        IWCompanyDetailViewController *vc = [[IWCompanyDetailViewController alloc] init];
        vc.policyId = banner.objectId;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // webview
        IWWebViewController *vc = [[IWWebViewController alloc] init];
        vc.navTitle = NSLocalizedString(@"home_detail", nil);
        vc.url = [NSString stringWithFormat:SERVER_VIEW_DETAIL, @"banner", banner.objectId, IWCompanyId, [IWUserTool user].loginId];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
     [IWNotificationCenter removeObserver:self];
}

/**
 *  加载banner
 */
- (void)setupBannerData {
    IWHomeBannerParam *param = [[IWHomeBannerParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(IWCompanyId);
    [IWHomeTool homeBannerWithParam:param success:^(IWHomeBannerResult *result) {
        if (result.code == 0) {
            // 设置banner数据
            self.scrollHeaderView.newses = result.datas;
        }
    } failure:^(NSError *error) {
    }];
}

- (void)loadMedicalArchives {
    [self loadMedicalArchives:nil];
}

- (IBAction)loadMedicalArchives:(UIButton *)sender {
    IWHealthFileViewController *vc = [[IWHealthFileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadTrainning:(UIButton *)sender {
    IWTrainningViewController *vc = [[IWTrainningViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadDoctorSign:(UIButton *)sender {
    IWDoctorSignViewController *vc = [[IWDoctorSignViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadNnpList:(UIButton *)sender {
    IWNppViewController *vc = [[IWNppViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loadInquiry {
    IWPicAndTextMessageDiagnoseController *vc = [[IWPicAndTextMessageDiagnoseController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)loadMyDoctor:(UIButton *)sender {
    IWMyDoctorViewController *vc = [[IWMyDoctorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
