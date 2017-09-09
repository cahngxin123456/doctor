//
//  IWNewsViewCell.m
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNewsViewCell.h"
#import "UIImageView+WebCache.h"
#import "IWNews.h"

@interface IWNewsViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@property (nonatomic, weak) UIView *divider;
@end

@implementation IWNewsViewCell

- (void)awakeFromNib {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
    
    // 圆角
//    self.imageIcon.layer.cornerRadius = self.imageIcon.frame.size.width * 0.5;
//    self.imageIcon.clipsToBounds = YES;
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

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"news";
    IWNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWNewsViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setNews:(IWNews *)news {
    _news = news;
    
    // 头像
    [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:news.thumb] placeholderImage:[UIImage imageWithName:@"app_default_img"]];
    
    // 标题
    [self.labelTitle setText:news.title];
    if (news.readStatus == 1 || news.learnStatus == 1) {
        // 已读
        [self.labelTitle setTextColor:[UIColor blackColor]];
        [self.labelTime setTextColor:IWGlobalColor];
    } else {
        // 未读
        [self.labelTitle setTextColor:[UIColor orangeColor]];
        [self.labelTime setTextColor:[UIColor orangeColor]];
    }
    
    // 时间
    [self.labelTime setText:news.insertTime];
    
    // 概要
    [self.labelContent setText:news.overview];
}


@end
