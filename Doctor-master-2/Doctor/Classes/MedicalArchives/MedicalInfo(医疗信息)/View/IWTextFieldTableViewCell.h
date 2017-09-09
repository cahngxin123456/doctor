//
//  IWTextFieldTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface IWTextFieldTableViewCell : UITableViewCell

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UITextField *textfield;




+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
