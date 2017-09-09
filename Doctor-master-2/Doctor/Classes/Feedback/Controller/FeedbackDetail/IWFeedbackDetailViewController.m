//
//  IWFeedbackDetailViewController.m
//  Conedot
//
//  Created by 范超 on 15/3/11.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWFeedbackDetailViewController.h"
#import "IWUserTool.h"
#import "IWNews.h"
#import "IWUser.h"
#import "IWCompanyTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "IWFanCompany.h"

@interface IWFeedbackDetailViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *keywordLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *replayTipLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayLabel;
@property (weak, nonatomic) IBOutlet UIView *replayLineView;

@property (nonatomic, weak) UIWebView *contentWebView;
@end

@implementation IWFeedbackDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"home_detail", nil);

    // 添加控件
    [self setupContent];
    
    // 设置数据
    [self setupData];
}

/**
 *  添加控件
 */
- (void)setupContent {
    // 内容
    UIWebView *contentWebView = [[UIWebView alloc] init];
    CGFloat contentWebViewX = 8;
    CGFloat contentWebViewY = CGRectGetMaxY(self.lineView.frame) + 10;
    CGFloat contentWebViewW = self.view.frame.size.width - 2 * contentWebViewX;
    CGFloat contentWebViewH = self.view.frame.size.height - contentWebViewY;
    contentWebView.frame = CGRectMake(contentWebViewX, contentWebViewY, contentWebViewW, contentWebViewH);
    contentWebView.backgroundColor = [UIColor clearColor];
    contentWebView.scrollView.showsVerticalScrollIndicator = NO;
    contentWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [contentWebView setScalesPageToFit:YES];
    contentWebView.delegate = self;
    [self.scrollView addSubview:contentWebView];
    self.contentWebView = contentWebView;
}

/**
 *  设置数据
 */
- (void)setupData {
    self.titleLabel.text = self.news.title;
    self.keywordLabel.text = self.news.keywords;
    
    IWCompanyDetailParam *param = [[IWCompanyDetailParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.companyId = @(self.company.companyId);
    param.feedbackId = self.feedbackId;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [IWCompanyTool companyDetailWithParam:param success:^(IWCompanyDetailResult *result) {
        if (result.code == 0) {
            // 设置数据
            [self setContent:result];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)setContent:(IWCompanyDetailResult *)result {
    // 设置系统回复
    if ([result.reply isEqualToString:@""] || result.reply == nil) {
        self.contentWebView.y = CGRectGetMaxY(self.lineView.frame) + 10;
        self.replayTipLabel.hidden = YES;
        self.replayLabel.hidden = YES;
        self.replayLineView.hidden = YES;
    } else {
        self.contentWebView.y = CGRectGetMaxY(self.replayLineView.frame) + 10;
        self.replayTipLabel.hidden = NO;
        self.replayLabel.hidden = NO;
        self.replayLineView.hidden = NO;
        self.replayLabel.text = result.reply;
        self.replayLabel.textColor = [UIColor orangeColor];
    }
    
    // 设置内容
    NSString *strTemplateHTML = [NSString stringWithFormat:@"<html xmlns=\"http://www.w3.org/1999/xhtml\"> <head> <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><style type='text/css'>p{font-size:50px;}</style></head><body style='margin:0; padding:0;'><p>%@</p></body></html>", result.content];
    [self.contentWebView loadHTMLString:strTemplateHTML baseURL:nil];
}


@end
