//
//  IWCommonContactCell.h
//  Conedot
//
//  Created by 范超 on 16/4/9.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWCommonContact;

@interface IWCommonContactCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWCommonContact *contact;
@end
