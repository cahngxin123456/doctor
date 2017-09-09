//
//  IWProfileIconTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWProfileIconTableViewCell : UITableViewCell



//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UIImageView *iconImageView;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
