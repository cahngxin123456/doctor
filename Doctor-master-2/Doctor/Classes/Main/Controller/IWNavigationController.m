//
//  IWNavigationController.m
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface IWNavigationController ()

@end

@implementation IWNavigationController

+ (void)initialize {
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme {
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = iOS7 ? [UIColor orangeColor] : [UIColor grayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 15 : 12];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] =  [UIColor lightGrayColor];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    // 设置向item右边的按钮
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme {
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    [navBar setBackgroundImage:[UIImage imageWithName:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    // 设置标题属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    [navBar setTitleTextAttributes:textAttrs];
    [navBar setTintColor:[UIColor blackColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏左边按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_back" highImageName:@"top_back_press" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
