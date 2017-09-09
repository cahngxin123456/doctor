//
//  IWCompanyDetailViewController.m
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWCompanyDetailViewController.h"
#import "IWCompany.h"
#import "IWFanCompany.h"
#import "IWCompanyTool.h"
#import "IWUserTool.h"
#import "IWUser.h"
#import "IWToast.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "IWDetailBottomView.h"
#import "IWDetailBottom2View.h"
#import "IWDetailBottom3View.h"
#import "IWTextField.h"
#import "IWDetailExtendInfo.h"
#import "IWNews.h"

#define IWDetailMargin 10
#define IWDetailTitleFont [UIFont systemFontOfSize:18]
#define IWDetailContentFont [UIFont systemFontOfSize:14]

@interface IWCompanyDetailViewController () <UIGestureRecognizerDelegate, UIWebViewDelegate, IWDetailBottomViewDelegate, IWDetailBottom2ViewDelegate, IWDetailBottom3ViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *details;
@property (nonatomic, strong) IWCompanyDetailResult *result;
@property (nonatomic, strong) NSString *review;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, weak) UIButton *commenButton;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIWebView *contentWebView;
@property (nonatomic, weak) IWDetailBottomView *bottomView;
@property (nonatomic, weak) IWDetailBottom2View *bottomView2;
@property (nonatomic, weak) IWDetailBottom3View *bottomView3;
@end

@implementation IWCompanyDetailViewController

- (NSMutableArray *)details {
    if (_details == nil) {
        _details = [NSMutableArray array];
    }
    return _details;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    // 设置从首页过来的
    [self setupHomeDetail];

    // 设置导航栏
    [self setupNavBar];
    
    // 设置控件
    [self setupWidget];
    
    // 加载数据
    [self loadData];
    
    // 设置webview的点击事件
    if (!self.feedbackId) {  // 反馈详情页面不需要点击
        [self addTapOnWebView];
    }
}

/**
 *  设置从首页过来的
 */
- (void)setupHomeDetail {
    if (self.company) { // 从公司列表页面点击进入
        if ([self.company.category isEqualToString:@"notice"]) {
            self.noticeId = self.company.ID;
        } else if ([self.company.category isEqualToString:@"policy"]) {
            self.policyId = self.company.ID;
        } else {
            self.newsId = self.company.ID;
        }
    }
}

/**
 *  设置webview的点击事件
 */
-(void)addTapOnWebView {
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.contentWebView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}

#pragma mark- TapGestureRecognizer

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)recongnizer {
    CGPoint pt = [recongnizer locationInView:self.contentWebView];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    NSString *url = [self.contentWebView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (url == nil || [url isEqualToString:@""]) {
        return;
    }
    int count = self.result.listImg.count;
    // 1.封装图片数据
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        if ([url isEqualToString:self.result.listImg[i]]) {
            NSLog(@"image url=%@", url);
        }
        
        // 一个MJPhoto对应一张显示的图片
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
 
        NSString *photoUrl = self.result.listImg[i];
        mjphoto.url = [NSURL URLWithString:photoUrl]; // 图片路径
        
        [myphotos addObject:mjphoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = recongnizer.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = myphotos; // 设置所有的图片
    [browser show];
}

/**
 *  设置控件
 */
- (void)setupWidget {
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = IWDetailTitleFont;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.3;
    [self.view addSubview:lineView];
    self.lineView = lineView;
    
    // 内容
    UIWebView *contentWebView = [[UIWebView alloc] init];
    contentWebView.backgroundColor = [UIColor clearColor];
    contentWebView.scrollView.showsVerticalScrollIndicator = NO;
    contentWebView.delegate = self;
    contentWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [contentWebView setScalesPageToFit:YES];
    [self.view addSubview:contentWebView];
    self.contentWebView = contentWebView;
    
    // 工具条
    IWDetailBottomView *bottomView = [IWDetailBottomView detailBottomView];
    bottomView.delegate = self;
    CGFloat bottomViewW = self.view.frame.size.width;
    CGFloat bottomViewH = 40;
    CGFloat bottomViewX = 0;
    CGFloat bottomViewY;
//    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.1) {
//        bottomViewY = self.view.frame.size.height - bottomViewH - 60;
//    } else {
        bottomViewY = self.view.frame.size.height - bottomViewH - 60;
//    }
    bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    // 通知的工具条
    IWDetailBottom2View *bottomView2 = [IWDetailBottom2View detailBottom2View];
    bottomView2.delegate = self;
    bottomView2.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView2];
    self.bottomView2 = bottomView2;
    
    // 培训学习任务工具条
    IWDetailBottom3View *bottomView3 = [IWDetailBottom3View detailBottom3View];
    bottomView3.delegate = self;
    bottomView3.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:bottomView3];
    self.bottomView3 = bottomView3;
    
    // 判断
    if (self.noticeId || self.activityId) {
        [self.bottomView setHidden:YES];
        [self.bottomView2 setHidden:NO];
        [self.bottomView3 setHidden:YES];
    } else if (self.learnTaskId) {
        [self.bottomView setHidden:YES];
        [self.bottomView2 setHidden:YES];
        [self.bottomView3 setHidden:NO];
    } else {
        [self.bottomView setHidden:NO];
        [self.bottomView2 setHidden:YES];
        [self.bottomView3 setHidden:YES];
    }
    
    if (self.feedbackId) {
        [self.bottomView setHidden:YES];
        [self.bottomView2 setHidden:YES];
        [self.bottomView3 setHidden:YES];
    }
    
    if (self.activityId) {
        UIBarButtonItem *more = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithName:@"more_normal"] style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
        self.navigationItem.rightBarButtonItems = @[more];
    }
}

// 分享
- (void)more:(UIBarButtonItem *)item {
    // 分享内容
    NSString *url = [NSString stringWithFormat:@"%@", self.url];
    NSString *title = [NSString stringWithFormat:@"%@", self.news.title];
    NSString *content = [NSString stringWithFormat:@"%@", self.news.overview];
    NSString *weiboContent = [NSString stringWithFormat:@"%@  %@  %@", title, content, url];
    NSString *weiXinContent = [NSString stringWithFormat:@"%@", content];
    UIImage *shareImage = [UIImage imageWithName:@"share_icon"];
}

/**
 *  设置导航栏
 */
- (void)setupNavBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.company ? [NSString stringWithFormat:@"%@-%@", self.company.companyName, self.company.categoryName] : NSLocalizedString(@"home_detail", nil);
}

/**
 *  加载数据
 */
- (void)loadData {
    IWCompanyDetailParam *param = [self setupDetailParam];
    
    [IWCompanyTool companyDetailWithParam:param success:^(IWCompanyDetailResult *result) {
        if (result.code == 0) {
            // 设置数据
            self.result =  result;
            [self setContent:result param:param];
        } else {
            [IWToast toastWithView:self.view title:result.info];
        }
    } failure:^(NSError *error) {
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (IWCompanyDetailParam *)setupDetailParam {
    IWCompanyDetailParam *param = [[IWCompanyDetailParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    if (self.company) { // 从公司列表页面点击进入
        param.companyId = @(IWCompanyId);
        if ([self.company.category isEqualToString:@"notice"]) {
            param.noticeId = self.company.ID;
        } else if ([self.company.category isEqualToString:@"policy"]) {
            param.policyId = self.company.ID;
        } else {
            param.newsId = self.company.ID;
        }
    } else { // 从公司页面点击进入
        param.companyId = @(IWCompanyId);
        if (self.noticeId) {
            param.noticeId = self.noticeId;
            param.type = @"notice";
            self.ID = param.noticeId;
        } else if (self.policyId) {
            param.policyId = self.policyId;
            param.type = @"policy";
            self.ID = param.policyId;
        } else if (self.feedbackId) {
            param.feedbackId = self.feedbackId;
        } else if (self.trainningSystemId) {
            param.companyId = @(IWCompanyId);
            param.manualId = self.trainningSystemId;
            param.type = @"manual";
            self.ID = param.manualId;
        } else if (self.learnTaskId) {
            param.companyId = @(IWCompanyId);
            param.learnTaskId = self.learnTaskId;
            param.type = @"learnTask";
            self.ID = param.learnTaskId;
        } else if (self.activityId) {
            param.activityId = self.activityId;
            param.type = @"activity";
            self.ID = param.activityId;
        } else {
            param.newsId = self.newsId;
            param.type = @"news";
            self.ID = param.newsId;
        }
    }
    
    return param;
}

/**
 *  报名
 */
- (void)apply2:(UIButton *)button {
    IWCompanyDetailParam *param = [self setupDetailParam];
    
    [IWCompanyTool companyApplyWithParam:param success:^(IWCompanyDetailResult *result) {
        if (result.code == 0) {
            [IWToast toastWithView:self.view title:NSLocalizedString(@"send_success", nil)];
            button.selected = YES;
        } else {
            [IWToast toastWithView:self.view title:result.info];
            button.selected = NO;
        }
    } failure:^(NSError *error) {
        button.enabled = NO;
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)known2:(UIButton *)button {
    [self known:button];
}

- (void)known3:(UIButton *)button {
    [self known:button];
}


/**
 *  已了解
 */
- (void)known:(UIButton *)button {
    IWCompanyDetailParam *param = [self setupDetailParam];
    
    [IWCompanyTool companyKnownWithParam:param success:^(IWCompanyDetailResult *result) {
        if (result.code == 0) {
            [IWToast toastWithView:self.view title:NSLocalizedString(@"send_success", nil)];
            button.selected = YES;
        } else {
            [IWToast toastWithView:self.view title:result.info];
            button.selected = NO;
        }
    } failure:^(NSError *error) {
        button.enabled = NO;
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)signup2:(UIButton *)button {
    [self signup:button];
}

/**
 *  赞
 */
- (void)signup:(UIButton *)button {
    IWCompanyDetailParam *param = [self setupDetailParam];
    
    [IWCompanyTool companySignUpWithParam:param success:^(IWCompanyDetailResult *result) {
        if (result.code == 0) {
            [IWToast toastWithView:self.view title:NSLocalizedString(@"send_success", nil)];
            button.selected = YES;
        } else {
            [IWToast toastWithView:self.view title:result.info];
            button.selected = NO;
        }
    } failure:^(NSError *error) {
        button.enabled = NO;
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

- (void)comment2:(UIButton *)button {
    [self comment:button];
}

/**
 *  评论
 */
- (void)comment:(UIButton *)button {
    self.commenButton = button;
    // 对话框
    NSString *content = ![self.review isEqualToString:@""] ? self.review : @"";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入评论" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField=[alertView textFieldAtIndex:0];
    textField.text = content;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *textField=[alertView textFieldAtIndex:0];
        NSString *content = textField.text;

        // 提交服务器
        IWCompanyDetailParam *param = [self setupDetailParam];
        param.review = [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [IWCompanyTool companyCommentWithParam:param success:^(IWCompanyDetailResult *result) {
            if (result.code == 0) {
                [IWToast toastWithView:self.view title:NSLocalizedString(@"send_success", nil)];
                self.review = content;
                self.commenButton.selected = true;
            } else {
                [IWToast toastWithView:self.view title:result.info];
            }
        } failure:^(NSError *error) {
            [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
        }];

    }
}

- (void)setContent:(IWCompanyDetailResult *)result param: (IWCompanyDetailParam *)param {
    // 屏幕的高宽
    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    // 内容
    CGFloat contentLabelX = 0;
    CGFloat contentLabelY = 0;;
    CGFloat contentLabelW = w;
    CGFloat contentLabelH = h - contentLabelY - 3 * IWDetailMargin;
    self.contentWebView.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);

    NSString *url = [NSString stringWithFormat:SERVER_VIEW_DETAIL, param.type, self.ID, self.fanCompany == nil ?[param.companyId longValue] : IWCompanyId ,[IWUserTool user].loginId];
    self.url = url;
    [self.contentWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    // 工具条状态
    IWDetailExtendInfo *extendInfo = result.extendInfo;
    self.review = extendInfo.review;
    if (extendInfo != nil) {
        if (self.noticeId || self.activityId) {
            [self.bottomView2 setStatus:extendInfo];
        } else if (self.learnTaskId) {
            [self.bottomView3 setStatus:extendInfo];
        } else {
            [self.bottomView setStatus:extendInfo];
        }
    }
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSURL *requestedURL = [request URL];
        return ![[UIApplication sharedApplication]openURL:requestedURL];
    }
    return YES;
}

@end
