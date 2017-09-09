//
//  IWNotificationViewCell.h
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWNotification;

@interface IWNotificationViewCell : UITableViewCell
@property (nonatomic, strong) IWNotification *notification;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
