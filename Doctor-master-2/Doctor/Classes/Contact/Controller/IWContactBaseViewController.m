//
//  IWContactBaseViewController.m
//  Conedot
//
//  Created by 范超 on 15/4/16.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactBaseViewController.h"
#import "IWContactTool.h"

@interface IWContactBaseViewController ()

@end

@implementation IWContactBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加控件
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.width, 30);
    view.backgroundColor = IWTableViewBgColor;
    
    NSString *title = [[NSUserDefaults standardUserDefaults] stringForKey:UserDefaultContactHeaderTitle];
    UILabel *label = [[UILabel alloc] init];
    label.x = 10;
    label.y = 0;
    label.width = view.width;
    label.height = view.height;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    self.tableView.tableHeaderView = view;
    
    // 设置文字
    NSString *result = nil;
    if (self.nTitle == nil) {
        result = title;
    } else {
        result = [NSString stringWithFormat:@"%@->%@", title, self.nTitle];
    }
    
    if (result != nil) {
        NSDictionary *attrs = @{ NSForegroundColorAttributeName : IWGlobalColor };
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:result];
        NSRange last = [result rangeOfString:@"->" options:NSBackwardsSearch];
        if (last.location != NSNotFound) {
            NSRange range = NSMakeRange(0, last.location);
            [attrStr addAttributes:attrs range:range];
        }
        label.attributedText = attrStr;
    }
}

- (void)setNTitle:(NSString *)nTitle {
    _nTitle = nTitle;
}

- (void)setTopTitle:(NSString *)topTitle {
    _topTitle = topTitle;
}

@end
