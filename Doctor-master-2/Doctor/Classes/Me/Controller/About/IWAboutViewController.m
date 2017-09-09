//
//  IWAboutViewController.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAboutViewController.h"
#import "IWAboutHeaderView.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"

@interface IWAboutViewController () {
     UIWebView *_webView;
}
@end

@implementation IWAboutViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"about", nil);
    _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    [self setupGroup0];
    
    [self.tableView setTableHeaderView:[IWAboutHeaderView headerView]];
}

- (void)setupGroup0 {
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *mark = [IWSettingArrowItem itemWithTitle:NSLocalizedString(@"mark", nil)];
    mark.option = ^{
        UIApplication *app = [UIApplication sharedApplication];
        NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8", IWAppID];
        NSURL *url = [NSURL URLWithString:urlStr];
        if ([app canOpenURL:url]) {
            [app openURL:url];
        }
    };
    
    IWSettingArrowItem *customer_phone = [IWSettingArrowItem itemWithTitle:NSLocalizedString(@"customer_phone", nil)];
    __unsafe_unretained IWAboutViewController *about = self;
    customer_phone.subtitle = @"4006165987";
    customer_phone.option = ^{
        [about->_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006165987"]]];
    };
    
    group.items = @[mark, customer_phone];
}

@end
