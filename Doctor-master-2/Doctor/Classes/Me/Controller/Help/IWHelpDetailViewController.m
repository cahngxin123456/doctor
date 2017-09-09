//
//  IWHelpDetailViewController.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHelpDetailViewController.h"
#import "IWHelp.h"
#import "IWUser.h"
#import "IWUserTool.h"
#import "IWMeTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWToast.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface IWHelpDetailViewController () <UIWebViewDelegate>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *divider;
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation IWHelpDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#ifdef __IPHONE_7_0
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    // 设置导航
    [self setupNavBar];
    
    // 添加view
    [self setupView];
    
    // 加载数据
    [self setupData];
}

/**
 *  添加view
 */
- (void)setupView {
    // 添加标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.numberOfLines = 0;
    [self.view addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    // 分割线
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.4;
    [self.view addSubview:divider];
    self.divider = divider;
    
    // 添加webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [webView setScalesPageToFit:NO];
    [self.view addSubview:webView];
    self.webView = webView;
}

/**
 *  设置导航栏
 */
- (void)setupNavBar {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"help_feedback", nil);
}

/**
 *  加载数据
 */
- (void)setupData {
    IWHelpDetailParam *param = [[IWHelpDetailParam alloc] init];
    param.loginId = [IWUserTool user].loginId;
    param.feedbackId = self.help.ID;
    
    // 显示Loading
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [IWMeTool helpDetailWithParam:param success:^(IWHelpDetailResult *result) {
        if (result.code == 0) {
            // 设置数据
            [self setupView:result];
        } else {
            // 请求失败
            [IWToast toastWithView:self.view title:NSLocalizedString(result.info, nil)];
        }
        // 关闭loading
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSError *error) {
        // 关闭loading
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [IWToast toastWithView:self.view title:NSLocalizedString(@"net_error", nil)];
    }];
}

/**
 *  设置view
 *
 *  @param result 返回的结果值
 */
- (void)setupView:(IWHelpDetailResult *)result {
    // 屏幕的高宽
    CGFloat w = self.view.frame.size.width;
    CGFloat margin = 10;
    
    // 设置title
    CGFloat titleLabelX = margin;
    CGFloat titleLabelY = margin;
    CGFloat titleLabelW = w - 2 * margin;
    CGSize titleLabelSize = [result.title sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(titleLabelW, MAXFLOAT)];
    self.titleLabel.frame = (CGRect){{titleLabelX, titleLabelY}, titleLabelSize};
    self.titleLabel.text = result.title;
    
    // 设置线
    CGFloat dividerX = titleLabelX;
    CGFloat dividerY = CGRectGetMaxY(self.titleLabel.frame) + margin;
    CGFloat dividerW = titleLabelW;
    CGFloat dividerH = 1;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    
    // 设置content
    self.webView.y = CGRectGetMaxY(self.divider.frame);
    NSString *strTemplateHTML = [NSString stringWithFormat:@"<html><head><style>img{max-width:100%%;height:auto !important;width:auto !important;};</style></head><body>%@</body></html>", result.content];
    [self.webView loadHTMLString:strTemplateHTML baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight - 32;
//    self.webView.frame = newFrame;
    self.webView.scrollView.contentSize = CGSizeMake(newFrame.size.width, newFrame.size.height);
    
    IWLog(@"%@", NSStringFromCGRect(webView.frame));
}



@end
