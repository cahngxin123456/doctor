//
//  IWProfileArowTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWProfileArowTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *resultLabel;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
