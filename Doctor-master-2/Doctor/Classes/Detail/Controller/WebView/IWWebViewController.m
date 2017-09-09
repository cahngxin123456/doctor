//
//  IWWebViewController.m
//  Conedot
//
//  Created by 范超 on 15/6/7.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface IWWebViewController () <NJKWebViewProgressDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) NJKWebViewProgressView *progressView;
@property (nonatomic, strong) NJKWebViewProgress *progressProxy;
@end

@implementation IWWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBase];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [self.progressView removeFromSuperview];
}

- (void)setupBase {
    self.title = self.navTitle;
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    self.view = webView;
    self.webView = webView;
    
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    webView.delegate = self.progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
//    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER_BIRTHDAY_WISHES_DETAIL_URL, self.infoID];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // add by zcj 实现图片长按识别功能
    UILongPressGestureRecognizer* longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longPressed.delegate = self;
    [self.webView addGestureRecognizer:longPressed];
    // ]end
}


// add by zcj 长按识别图中二维码
- (void)longPressed:(UILongPressGestureRecognizer*)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [recognizer locationInView:self.webView];
    // 获取手势所在图片的URL，js中图片的地址是用src引用的
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", touchPoint.x, touchPoint.y];
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if (urlToSave.length == 0) {
        return;
    }
    
    [self showImageOptionsWithUrl:urlToSave];
}

- (void)showImageOptionsWithUrl:(NSString *)imgURL
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
    UIImage* image = [UIImage imageWithData:data];
    
    NSDictionary *options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             @"CIDetectorAccuracy", @"CIDetectorAccuracyHigh",nil];
    CIDetector *detector = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        detector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                      context:nil
                                      options:options];
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    // 识别图中二维码
    UIAlertAction *judgeCode = [UIAlertAction actionWithTitle:@"识别图中二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scannedResult]]){
            
            NSLog(@"%@",scannedResult);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scannedResult]];

            // 这里和第一种方法一样，根据scannedResult做相应的操作即可。下面是我项目中的浏览器控制器打开这个网页。
//            WebBrowser *webBrowser = [[WebBrowser alloc] initWithNibName:@"WebBrowser" bundle:[Util mainBundle]];
//            [webBrowser loadWebWithTitle:nil urlAddress:scannedResult];
//            [self.navigationController pushViewController:webBrowser animated:YES];
//            [webBrowser release];
            
        }else{
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:scannedResult]]];
////            [Util Alert:@"无法识别的网址" title:@"温馨提示"];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无法识别的网址" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
//            [alert show];
        }
    }];
    
    // 保存图片到手机
    UIAlertAction *saveImage = [UIAlertAction actionWithTitle:@"保存图片到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    // 取消
    UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    if (features.count >= 1) {
        [alertController addAction:judgeCode];
    }
    
    [alertController addAction:saveImage];
    [alertController addAction:cancell];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
// 功能：显示图片保存结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error){
//        [Util Alert:@"保存图片失败" title:@"温馨提示"];
        NSLog(@"失败");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"保存图片失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else {
        // 这一句仅仅是提示保存成功
//        [CJUtil showInBottomWithTitle:@"保存成功" backgroundColor:nil textColor:nil];
        NSLog(@"成功");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
@end
