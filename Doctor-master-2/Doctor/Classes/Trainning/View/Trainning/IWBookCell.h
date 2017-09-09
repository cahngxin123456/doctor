//
//  IWBookCell.h
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWBookItem;

@interface IWBookCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, assign, getter = isLastRowInSection) BOOL lastRowInSection;
@property (nonatomic, strong) IWBookItem *bookItem;
@end
