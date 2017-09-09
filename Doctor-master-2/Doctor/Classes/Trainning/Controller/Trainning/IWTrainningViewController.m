//
//  IWTrainningViewController.m
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTrainningViewController.h"
#import "IWTrainningBookViewController.h"
#import "IWTrainningManageViewController.h"
#import "IWTrainningKnowledgeViewController.h"
#import "IWNavigationController.h"
#import "IWTabBar.h"
#import "IWTabBarButton.h"
#import "IWFanCompany.h"
#import "IWUnRead.h"
#import "IWCompanyTool.h"
#import "IWUserTool.h"
#import "IWUser.h"

@interface IWTrainningViewController () <IWTabBarDelegate>
@property (nonatomic, weak) IWTabBar *customTabBar;

@property (nonatomic, weak) IWTrainningBookViewController *book;
@property (nonatomic, weak) IWTrainningManageViewController *manage;
@end

@implementation IWTrainningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化Tabbar
    [self setupTabbar];
    
    // 添加所有的子控制器
    [self addAllChildVcs];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    
    // 获取未读数
    [self getUnReadCount];
    
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

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to {
    self.selectedIndex = to;
    
    // 改变title
    IWTabBarButton *button = (IWTabBarButton *)tabBar.tabBarButtons[to];
    self.navigationItem.title = button.item.title;
    
    // 发送通知
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    if (to == 0) {
        [defaultCenter postNotificationName:@"book" object:button userInfo:nil];
    } else if (to == 1) {
        [defaultCenter postNotificationName:@"manage" object:button userInfo:nil];
    } else if (to == 2) {
        [defaultCenter postNotificationName:@"knowledge" object:button userInfo:nil];
    }
}

- (void)setUnRead:(IWUnRead *)unRead {
    _unRead = unRead;
    if (self.unRead) {
        self.book.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", self.unRead.manutalTotalNum];
        self.book.unRead = self.unRead;
        
        self.manage.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", self.unRead.learnTaskNumber];
        self.manage.unRead = self.unRead;
    }
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs {
    IWTrainningBookViewController *book = [[IWTrainningBookViewController alloc] init];
    [self addOneChlildVc:book title:NSLocalizedString(@"trainning_book", nil) imageName:@"training_icon_handbook_normal" selectedImageName:@"training_icon_handbook_press"];
    self.book = book;
    
    IWTrainningManageViewController *manage = [[IWTrainningManageViewController alloc] init];
    [self addOneChlildVc:manage title:NSLocalizedString(@"trainning_manage", nil) imageName:@"training_icon_management_normal" selectedImageName:@"training_icon_management_press"];
    self.manage = manage;
    
    IWTrainningKnowledgeViewController *knowledge = [[IWTrainningKnowledgeViewController alloc] init];
    [self addOneChlildVc:knowledge title:NSLocalizedString(@"trainning_knowledge", nil) imageName:@"training_icon_knowledge_base_normal" selectedImageName:@"training_icon_knowledge_base_press"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 增加一个导航控制器
    [self addChildViewController:childVc];
    
    // 添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem titleColor:IWColor(0, 140, 238)];
}

/**
 *  子线程加载数据
 */
- (void)getUnReadCount {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(checkUnreadCount) object:nil];
    [thread start];
}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount {
    IWCompanyUnReadParam *param = [[IWCompanyUnReadParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @([IWCompanyTool fancompany].companyId);
    param.type = @"manual,learnTask";
    
    [IWCompanyTool unReadNumberWithParam:param success:^(IWCompanyUnReadResult *result) {
        // 设置公司的未读数
        IWUnRead *unRead = result.datas;
        
        // 设置tabBar上的数字
        [self setUnRead:unRead];
    } failure:^(NSError *error) {
    }];
}

@end
