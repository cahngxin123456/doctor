//
//  IwBloodPressureDataTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodPressureDetalModel.h"

@interface IwBloodPressureDataTableViewCell : UITableViewCell

@property (nonatomic, strong) IWBloodPressureDetalModel *model;
@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) UILabel *secondLabel;
@property (nonatomic, weak) UILabel *thirdabel;
@property (nonatomic, weak) UILabel *forthLabel;
//备注
@property (nonatomic, strong) UIView *viewOfRemark;

@property (nonatomic, strong) UIImageView *imageViewOf1;
@property (nonatomic, strong) UIImageView *imageViewOf2;

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
