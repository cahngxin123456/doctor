//
//  IWMonitorTTTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/21.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodPressureModel.h"

@interface IWMonitorTTTableViewCell : UITableViewCell

@property (nonatomic, strong) IWBloodPressureModel *model;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *topLabel;
@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, weak) UILabel *centerLabel;

@property (nonatomic, weak) UIImageView *bottomView;
@property (nonatomic, weak) UIImageView *leftView;
@property (nonatomic, weak) UIImageView *rightView;
@property (nonatomic, weak) UIImageView *resultView;
@property (nonatomic, weak) UIImageView *bgView;






+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;



@end
