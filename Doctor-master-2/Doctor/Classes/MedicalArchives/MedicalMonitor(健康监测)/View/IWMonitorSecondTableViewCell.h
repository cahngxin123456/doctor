//
//  IWMonitorSecondTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodSugerModel.h"

@interface IWMonitorSecondTableViewCell : UITableViewCell


@property (nonatomic, strong) IWBloodSugerModel *model;
//时段
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *rightLabel;
@property (nonatomic, weak) UILabel *resultLabel;

//时段
@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIView *resultView;


@property (nonatomic, copy) NSString *strResource;





+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView StrResource:(NSString *)rsource;


@end
