//
//  IWFeedbackListCell.m
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFeedbackListCell.h"
#import "UIImageView+WebCache.h"
#import "IWNews.h"

@interface IWFeedbackListCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyworddLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (nonatomic, weak) UIView *divider;
@end

@implementation IWFeedbackListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"feedback";
    IWFeedbackListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWFeedbackListCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)awakeFromNib {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

/**
 *  在这个方法中设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 0.5;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

- (void)setNews:(IWNews *)news {
    _news = news;
    
    // 标题
    [self.titleLabel setText:news.title];
    
    // 时间
    [self.timeLabel setText:news.insertTime];
    
    // 关键字
    NSString *keys = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"feedback_keywords", nil), news.keywords];
    [self.keyworddLabel setText:keys];
    
    // 状态
    self.statusLabel.text = news.usingStatus2show;
    if ([news.usingStatus2show isEqualToString:@"已提交"]) {
        self.statusLabel.textColor = [UIColor lightGrayColor];
    } else if ([news.usingStatus2show isEqualToString:@"处理中"]) {
        self.statusLabel.textColor = [UIColor orangeColor];
    } else if ([news.usingStatus2show isEqualToString:@"已解决"]) {
        self.statusLabel.textColor = IWColor(2, 124, 11);
    }
}

@end
