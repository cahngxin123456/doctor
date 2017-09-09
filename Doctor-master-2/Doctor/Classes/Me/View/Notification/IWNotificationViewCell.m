//
//  IWNotificationViewCell.m
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNotificationViewCell.h"
#import "IWNotification.h"

@interface IWNotificationViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation IWNotificationViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"notification";
    IWNotificationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWNotificationViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setNotification:(IWNotification *)notification {
    _notification = notification;
    
    // 是否已读
    if (notification.status == 0) {
        // 未读
        [self.titleLabel setTextColor:IWColor(219, 135, 56)];
    } else {
        // 已读
        [self.titleLabel setTextColor:[UIColor grayColor]];
    }
    
    // 标题
    [self.titleLabel setText:notification.title];
    
    // 时间
    [self.timeLabel setText:notification.insertTime];
}


@end
