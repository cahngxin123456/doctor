//
//  IWWebViewController.h
//  Conedot
//
//  Created by 范超 on 15/6/7.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWWebViewController : UIViewController
@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, weak) UIWebView *webView;
@end
