//
//  IWFanCompanySettingViewCell.h
//  Conedot
//
//  Created by 范超 on 14-10-14.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWFanCompany;

@protocol IWFanCompanySettingViewCellDelegate <NSObject>
@optional
- (void)switchStatusWithFan:(IWFanCompany *)fanId usingStatus:(int)usingStatus;
@end

@interface IWFanCompanySettingViewCell : UITableViewCell
@property (nonatomic, strong) IWFanCompany *fan;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) id<IWFanCompanySettingViewCellDelegate> delegate;
@end
