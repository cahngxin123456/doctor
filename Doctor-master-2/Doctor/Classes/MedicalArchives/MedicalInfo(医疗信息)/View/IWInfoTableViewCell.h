//
//  IWInfoTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>

@interface IWInfoTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UIImageView *bgView;

@property (nonatomic, weak) UIImageView *editImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *resultLabel;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath *)index;


@end
