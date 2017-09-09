//
//  IWContactCell.h
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWContact;

@interface IWContactCell : UITableViewCell
@property (nonatomic, strong) IWContact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
