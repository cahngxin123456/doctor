//
//  IWContactAlertView.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactAlertView.h"
#import "IWPeopleCacheTool.h"
#import "IWContactButton.h"
#import "IWPeople.h"
#import "IWToast.h"
#import "IWUserInfoViewController.h"
#import "IWNavigationController.h"

#define Alertwidth 260.0f
#define Alertheigth 130.0f

@interface IWContactAlertView()


@property (nonatomic, strong) IWPeople *people;

@property (nonatomic, weak) UIView *blackOpaqueView;
@property (nonatomic, strong) UILabel * messageLabel; // Default is in gray color and system font 14

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation IWContactAlertView

- (instancetype)initWithPeople:(IWPeople *)people {
    if (self = [super init]) {
        self.layer.cornerRadius = 6.0;
        self.clipsToBounds = YES;
        self.people= people;
        [self setupItems];
    }
    return self;
}

- (void)setupItems {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    // 内容
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.frame = CGRectMake(0, 0, Alertwidth, Alertheigth * 0.5);
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.text = self.people.userName;
    messageLabel.textColor = IWColor(54, 109, 140);
    messageLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:messageLabel];
    self.messageLabel = messageLabel;
    
    CGFloat buttonW = Alertwidth / 3;;
    CGFloat buttonH = Alertheigth * 0.5;
    // 打电话按钮
    IWContactButton *button1 = [[IWContactButton alloc] init];
    CGFloat button1X = 0;
    CGFloat button1Y = buttonH;
    CGFloat button1W = buttonW;
    CGFloat button1H = buttonH;
    button1.frame = CGRectMake(button1X, button1Y, button1W, button1H);
    [button1 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_left_normal" left:0.5 top:0.5] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_left_pressed" left:0.5 top:0.5] forState:UIControlStateHighlighted];
    [button1 setImage:[UIImage imageNamed:@"phone_normal"] forState:UIControlStateNormal];
    [button1 setTitle:NSLocalizedString(@"dial_phone", nil) forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dialPhone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button1];
    
    // 发邮件按钮
    IWContactButton *button2 = [[IWContactButton alloc] init];
    CGFloat button2X = CGRectGetMaxX(button1.frame);
    CGFloat button2Y = buttonH;
    CGFloat button2W = buttonW;
    CGFloat button2H = buttonH;
    button2.frame = CGRectMake(button2X, button2Y, button2W, button2H);
    [button2 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_middle_normal" left:0.5 top:0.5] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_middle_pressed" left:0.5 top:0.5] forState:UIControlStateHighlighted];
    [button2 setImage:[UIImage imageNamed:@"mail_normal"] forState:UIControlStateNormal];
    [button2 setTitle:NSLocalizedString(@"send_mail", nil) forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(sendMail) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    // 查看个人信息按钮
    IWContactButton *button3 = [[IWContactButton alloc] init];
    CGFloat button3X = CGRectGetMaxX(button2.frame);
    CGFloat button3Y = buttonH;
    CGFloat button3W = buttonW;
    CGFloat button3H = buttonH;
    button3.frame = CGRectMake(button3X, button3Y, button3W, button3H);
    [button3 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_right_normal" left:0.5 top:0.5] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage resizedImageWithName:@"button_user_info_right_pressed" left:0.5 top:0.5] forState:UIControlStateHighlighted];
    [button3 setImage:[UIImage imageNamed:@"personal_information_normal"] forState:UIControlStateNormal];
    [button3 setTitle:NSLocalizedString(@"person_info", nil) forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(personInfo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
}

- (void)dialPhone {
    [self showMoreContactDialog];
}

#pragma mark - 使用系统邮件客户端发送邮件
- (void)sendMail {
    NSMutableString *mailUrl = [[NSMutableString alloc]init];
    if (![self.people.mail isEqualToString:@""]) {
        // 隐藏dialog
        [self dismiss];
        // 添加近最近联系人
        [self addRecentPeople];
        //添加收件人
        NSArray *toRecipients = [NSArray arrayWithObject: self.people.mail];
        [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
        NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
    } else {
        [IWToast toastWithView:self title:NSLocalizedString(@"user_no_phone", nil)];
    }
}
/**
 *  进入个人信息页面
 */
- (void)personInfo {
    if ([self.delegate respondsToSelector:@selector(peopleInfo:)]) {
        // 隐藏dialog
        [self dismiss];
        [self.delegate peopleInfo:self];
    }
}

// 显示更多联系人的对话框
- (void)showMoreContactDialog {
    NSArray *phones = self.people.phones;
    UIAlertView *alertView = nil;
    if (phones.count == 1){
       alertView = [[UIAlertView alloc] initWithTitle:self.people.userName message:phones[0] delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:NSLocalizedString(@"dial_phone", nil), nil]; 
    } else if (phones.count == 2) {
        alertView = [[UIAlertView alloc] initWithTitle:self.people.userName message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:phones[0], phones[1], nil];
    } else if (phones.count == 3) {
        alertView = [[UIAlertView alloc] initWithTitle:self.people.userName message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:phones[0], phones[1], phones[2], nil];
    } else if (phones.count == 4) {
        alertView = [[UIAlertView alloc] initWithTitle:self.people.userName message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", nil) otherButtonTitles:phones[0], phones[1], phones[2], phones[3], nil];
    }
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > self.people.phones.count || buttonIndex == 0) { // 取消按钮
        return;
    }
    NSString *phone = self.people.phones[buttonIndex - 1];
    IWLog(@"%@", phone);
    [self dialPhone:phone];
}

// 拨打电话
- (void)dialPhone:(NSString *)phone {
    // 隐藏dialog
    [self dismiss];
    // 添加近最近联系人
    [self addRecentPeople];
    // 拨打电话
    NSString *real_phone = [NSString stringWithFormat:@"tel://%@", phone];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:real_phone]]];
}

/**
 *  添加近最近联系人
 */
- (void)addRecentPeople {
    [IWPeopleCacheTool addPeople:self.people];
    // 发通知
    [IWNotificationCenter postNotificationName:@"fanChange" object:self];
}

- (void)show {
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - Alertwidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - Alertheigth) * 0.5-20, Alertwidth, Alertheigth);
    self.backgroundColor = IWColor(236, 237, 239);
    
    UIView *blackOpaqueView = [[UIView alloc] initWithFrame:topVC.view.bounds];
    blackOpaqueView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    UITapGestureRecognizer *outsideTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(outsideTap:)];
    [blackOpaqueView addGestureRecognizer:outsideTapGesture];
    [topVC.view addSubview:blackOpaqueView];
    self.blackOpaqueView  = blackOpaqueView;
    
    [blackOpaqueView addSubview:self];
}

- (void)outsideTap:(UITapGestureRecognizer *)recognizer {
    [self dismiss];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.blackOpaqueView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
