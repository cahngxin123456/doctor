//
//  IWCommonContactCell.m
//  Conedot
//
//  Created by 范超 on 16/4/9.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWCommonContactCell.h"
#import "IWCommonContact.h"

@interface IWCommonContactCell()
@property (nonatomic, weak) UIView *divider;

@end

@implementation IWCommonContactCell

/**
 *  在这个方法中设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 10;
    CGFloat dividerH = 0.5;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"contact";
    IWCommonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWCommonContactCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.5;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)setContact:(IWCommonContact *)contact {
    _contact = contact;
    
    // title
    self.textLabel.text = contact.title;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    // desc
    self.detailTextLabel.text = contact.number;
    self.detailTextLabel.font = [UIFont systemFontOfSize:13];
    self.detailTextLabel.textColor = IWGlobalColor;
}

@end
