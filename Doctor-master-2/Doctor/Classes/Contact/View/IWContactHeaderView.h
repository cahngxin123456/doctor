//
//  IWContactHeaderView.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWContactGroup;

@interface IWContactHeaderView : UITableViewHeaderFooterView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWContactGroup *group;

@end
