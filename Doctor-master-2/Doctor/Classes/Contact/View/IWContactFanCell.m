//
//  IWContactFanCell.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactFanCell.h"
#import "IWFanCompany.h"

@interface IWContactFanCell()
@property (nonatomic, weak) UIView *divider;

@end

@implementation IWContactFanCell

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
    IWContactFanCell *cell = [[IWContactFanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
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

/**
 *  设置透明色
 */
- (void)setClearBackground {
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.textLabel.textColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    UIView *view = [[UIView alloc] init] ;
    [view setBackgroundColor:IWColorWithAlpha(204, 204, 204, 0.5)];
    self.selectedBackgroundView = view;
}

- (void)setFan:(IWFanCompany *)fan {
    _fan = fan;
    
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.text = fan.companyNickname;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
