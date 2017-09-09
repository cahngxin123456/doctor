//
//  IWButtonTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface IWButtonTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UIImageView *arrowImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *resultLabel;
@property (nonatomic, weak) UIView *whiteView;


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
