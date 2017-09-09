//
//  IWFeedbackListCell.h
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWNews;

@interface IWFeedbackListCell : UITableViewCell
@property (nonatomic, strong) IWNews *news;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
