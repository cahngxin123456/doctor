//
//  IWHelpCell.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHelpCell.h"
#import "IWHelp.h"

@interface IWHelpCell()
@property (nonatomic, weak) UIView *divider;
@end

@implementation IWHelpCell

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
    static NSString *ID = @"help";
    IWHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[IWHelpCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 分割线
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.2;
        [self.contentView addSubview:divider];
        self.divider = divider;
        
        // 设置属性
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHelp:(IWHelp *)help {
    _help = help;
    
    self.textLabel.text = help.title;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
