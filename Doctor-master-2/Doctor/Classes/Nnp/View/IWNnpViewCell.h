//
//  IWNnpViewCell.h
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import <UIKit/UIKit.h>
@class IWNews;

@interface IWNnpViewCell : UITableViewCell
@property (nonatomic, strong) IWNews *news;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
