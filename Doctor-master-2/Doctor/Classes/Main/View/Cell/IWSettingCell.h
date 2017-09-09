//
//  IWSettingCell.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBgCell.h"

@class IWSettingItem;

@interface IWSettingCell : IWBgCell
@property (nonatomic, strong) IWSettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
