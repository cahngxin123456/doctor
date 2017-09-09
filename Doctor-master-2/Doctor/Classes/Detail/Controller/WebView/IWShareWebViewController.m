//
//  IWShareWebViewController.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWShareWebViewController.h"
#import <UShareUI/UShareUI.h>

@interface IWShareWebViewController ()

@end

@implementation IWShareWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置右边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"share", nil) style:UIBarButtonItemStyleDone target:self action:@selector(shareButton)];
}

- (void)shareButton {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
    
    
    // 分享内容
//    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_GET_CARD_SHARE_DETAIL_URL, [IWUserTool user].loginId];
//    NSString *title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"card_forword_title", nil)];
//    NSString *content = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"card_forword_title", nil), [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"card_forword_title", nil), @""]];
//    NSString *weiboContent = [NSString stringWithFormat:@"%@%@%@", title, content, url];
//    NSString *weiXinContent = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"card_forword_title", nil), content];
//    UIImage *shareImage = [UIImage imageWithName:@"share_icon"];
//    
//    // 打开分享页面
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_APPKEY shareText:content shareImage:shareImage shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQzone, UMShareToSina, UMShareToQQ, UMShareToEmail, UMShareToSms, nil] delegate:nil];
//    
//    // QQ
//    [UMSocialData defaultData].extConfig.qqData.url = url;
//    [UMSocialData defaultData].extConfig.qqData.title = title;
//    [UMSocialData defaultData].extConfig.qqData.shareText = weiXinContent;
//    [UMSocialData defaultData].extConfig.qzoneData.url = url;
//    [UMSocialData defaultData].extConfig.qzoneData.title = title;
//    [UMSocialData defaultData].extConfig.qzoneData.shareText = weiXinContent;
//    
//    // 微博
//    [UMSocialData defaultData].extConfig.sinaData.shareText = weiboContent;
//    [UMSocialData defaultData].extConfig.tencentData.shareText = weiboContent;
//    
//    // 微信
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = weiXinContent;
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//    
//    // 朋友圈
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = [NSString stringWithFormat:@"%@ %@",title, content];
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//    
//    // 邮箱，短信
//    NSString *emailText = [NSString stringWithFormat:@"%@ \n %@ \n %@", title, weiXinContent, url];
//    [UMSocialData defaultData].extConfig.emailData.shareText =  emailText;
//    [UMSocialData defaultData].extConfig.smsData.shareText = emailText;
//    [UMSocialData defaultData].extConfig.smsData.shareImage = [UIImage imageWithName:@"empty"];
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    NSString *url = self.url;
    NSString *title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"card_forword_title", nil)];
    NSString *content = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"card_forword_title", nil), [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"card_forword_title", nil), @""]];
    NSString *weiboContent = [NSString stringWithFormat:@"%@%@%@", title, content, url];
    NSString *weiXinContent = [NSString stringWithFormat:@"%@%@", NSLocalizedString(@"card_forword_title", nil), content];
    UIImage *shareImage = [UIImage imageWithName:@"share_icon"];

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = content;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
