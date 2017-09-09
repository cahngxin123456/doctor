//
//  IWFanCompanySettingViewCell.m
//  Conedot
//
//  Created by 范超 on 14-10-14.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFanCompanySettingViewCell.h"
#import "UIImageView+WebCache.h"
#import "IWFanCompany.h"

@interface IWFanCompanySettingViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *statusSwitch;


@end

@implementation IWFanCompanySettingViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"fan";
    IWFanCompanySettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWFanCompanySettingViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)awakeFromNib {
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width * 0.5;
    // 让内部的所有图层都遵循父图层的边框来显示
    // 超出父图层边框的内容全部不显示（裁剪掉）
    self.iconImage.layer.masksToBounds = YES;
}

- (void)changeStatus:(UISwitch *)switchButton {
    if ([self.delegate respondsToSelector:@selector(switchStatusWithFan:usingStatus:)]) {
        [self.delegate switchStatusWithFan:self.fan usingStatus:switchButton.isOn ? 1 : 0];
    }
}

- (void)setFan:(IWFanCompany *)fan {
    _fan = fan;
    
    // 头像
    [self.iconImage setImageWithURL:[NSURL URLWithString:fan.companyPhoto] placeholderImage:[UIImage imageWithName:@"app_default_img"]];
    
    // 标题
    [self.titleLabel setText:fan.companyNickname];
    
    // 状态
    [self.statusSwitch setOn:(fan.usingStatus == 1)];
    
    [self.statusSwitch addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventValueChanged];
}


@end
