//
//  IWTabBarViewController.m
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "IWTabBarViewController.h"
#import "IWTabBar.h"
#import "IWNavigationController.h"
#import "IWDepartmentViewController.h"
#import "IWHomeViewController.h"
#import "IWMeViewController.h"
#import "IWUserTool.h"
#import "IWCommonTool.h"
#import "IWUpdate.h"
#import "DXAlertView.h"
#import "IWProfileInfoViewController.h"

@interface IWTabBarViewController () <IWTabBarDelegate>
@property (nonatomic, weak) IWTabBar *customTabBar;

@property (nonatomic, strong) IWDepartmentViewController *contact;
@property (nonatomic, strong) IWHomeViewController *home;
@property (nonatomic, strong) IWMeViewController *me;

@end

@implementation IWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化Tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 子线程中看是否需要显示升级dialog
    [self setupUpdateDialog];
}

/**
 *  子线程中看是否需要显示升级dialog
 */
- (void)setupUpdateDialog {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(getVersion) object:nil];
    [thread start];
}

- (void)getVersion {
    IWGetVersionParam *param = [[IWGetVersionParam alloc] init];
    param.type = @"IOS";
    
    [IWCommonTool getVersionWithParam:param success:^(IWGetVersionResult *result) {
        // 比较服务器的跟当前的版本
        NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
        // 获得当前打开软件的版本号
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
        // Server存的版本
        NSString *lastVersion = result.datas.version;
        
        if ([lastVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
            // 显示dialog
            DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:NSLocalizedString(@"update_tip", nil) contentText:result.datas.updateMessage[@"zh"] leftButtonTitle:NSLocalizedString(@"update_no", nil) rightButtonTitle:NSLocalizedString(@"update_now", nil)];
            alertView.rightBlock = ^{
                UIApplication *app = [UIApplication sharedApplication];
                NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8", IWAppID];
                NSURL *url = [NSURL URLWithString:urlStr];
                if ([app canOpenURL:url]) {
                    [app openURL:url];
                }
            };
            [alertView show];
        }
    } failure:^(NSError *error) {
    }];
}

/**
 *  初始化Tabbar
 */
- (void)setupTabbar {
    IWTabBar *customTabBar = [[IWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"Main"];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"Main"];
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers {
    // 1.通讯录
    IWDepartmentViewController *contact = [[IWDepartmentViewController alloc] init];
    [self setupChildViewController:contact title:NSLocalizedString(@"contact", nil) imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.contact = contact;
    
    // 2.首页
    IWHomeViewController *home = [[IWHomeViewController alloc] init];
    [self setupChildViewController:home title:nil imageName:nil selectedImageName:nil];
    self.home = home;
    
    
    // 3.个人中心
    IWMeViewController *me = [[IWMeViewController alloc] init];
    [self setupChildViewController:me title:NSLocalizedString(@"me", nil) imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 增加一个导航控制器
    IWNavigationController *nav = [[IWNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    // 添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

/**
 *  后台发送登录请求
 */
- (void)setUser:(IWUser *)user {
    _user = user;
    
    [self loginBackground];
}

- (void)loginBackground {
    NSString *phone = self.user.cellphone;
    NSString *password = self.user.password;
    
    IWUserLoginParam *param = [[IWUserLoginParam alloc] init];
    param.loginName = phone;
    param.pwd = password;
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    NSString *channel = [NSString stringWithFormat:@"IOS-%@-V%@", [UIDevice currentDevice].systemVersion, currentVersion];
    param.channel = channel;
    param.deviceToken = [IWUserTool accessToken];
    [IWUserTool userLoginWithParam:param success:^(IWUserLoginResult *result) {
        // 存储模型数据
        IWUser *user = result.datas;
        if (user != nil) {
            user.pwd = param.pwd;
            user.password = password;
            [IWUserTool saveUser:user];
            
            // 判断是否需要跳转
            NSString *communityId = [NSString stringWithFormat:@"%@", user.communityId];
            if ([communityId isEqualToString:@""] || user.userName == nil || [user.userName isEqualToString:@""]) {
                [IWNotificationCenter postNotificationName:IWLoadUserUINotification object:self];
            }
        }
    } failure:^(NSError *error) {
    }];
}

@end
