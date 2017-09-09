//
//  IWPeopleCell.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWPeople;

@interface IWPeopleCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWPeople *people;
@end
