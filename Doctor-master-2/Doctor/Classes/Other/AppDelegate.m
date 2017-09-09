//
//  AppDelegate.m
//  Doctor
//
//  Created by 范超 on 16/12/17.
//
//

#import "AppDelegate.h"
#import "IWUserLoginViewController.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWTabBarViewController.h"
#import "UMMobClick/MobClick.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()
@property (nonatomic, strong) IWTabBarViewController *tabBar;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 友盟
    UMConfigInstance.appKey = UMENG_APPKEY;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];

    // 友盟分享
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];

    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMENG_APPKEY];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:IWWeiXinAppID appSecret:IWWeiXinAppSecret redirectURL:SERVER_ROOT];
    
    //设置分享到QQ互联的appKey和appSecret
    // U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:IWQQAppID  appSecret:IWQQAppSecret redirectURL:SERVER_ROOT];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:SERVER_ROOT];

    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    IWUserLoginViewController *login = [[IWUserLoginViewController alloc] init];
    IWUser *user = [IWUserTool user];
    if (user) {
        self.tabBar = [[IWTabBarViewController alloc] init];
        self.tabBar.user = user;
        self.window.rootViewController = self.tabBar;
    } else {
        self.window.rootViewController = login;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
