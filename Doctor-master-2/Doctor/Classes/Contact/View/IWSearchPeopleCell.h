//
//  IWSearchPeopleCell.h
//  Conedot
//
//  Created by 范超 on 15/3/11.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWPeople;

@interface IWSearchPeopleCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWPeople *people;

@property (nonatomic, copy) NSString *query;
@end
