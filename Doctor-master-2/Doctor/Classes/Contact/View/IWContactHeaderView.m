//
//  IWContactHeaderView.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactHeaderView.h"
#import "IWContactGroup.h"

@interface IWContactHeaderView()
@property (nonatomic, weak) UILabel *titleView;
@property (nonatomic, weak) UIView *divider;
@end

@implementation IWContactHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"header";
    IWContactHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[IWContactHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加文字控件
        UILabel *titleView = [[UILabel alloc] init];
        self.contentView.backgroundColor = [UIColor whiteColor];
        titleView.textColor = IWGlobalColor;
        titleView.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        
        // 添加线
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.5;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 文字
    CGFloat titleX = 10;
    CGFloat titleY = 0;
    CGFloat titleW = self.frame.size.width;
    CGFloat titleH = self.frame.size.height;
    self.titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 线条
    CGFloat dividerX = 0;
    CGFloat dividerH = 0.5;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

- (void)setGroup:(IWContactGroup *)group {
    _group = group;
    
    self.titleView.text = group.header;
}

@end
