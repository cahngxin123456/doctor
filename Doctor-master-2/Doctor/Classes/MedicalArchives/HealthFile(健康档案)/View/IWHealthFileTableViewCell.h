//
//  IWHealthFileTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/18.
//
//

#import <UIKit/UIKit.h>
#import "IWHealhFileModel.h"

@interface IWHealthFileTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *familyLabel;
@property (nonatomic, weak) UIImageView *sexImageView;
@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;

@property (nonatomic, weak) UIView *leftLineView;
@property (nonatomic, weak) UIView *rightLineView;
@property (nonatomic, weak) UIView *lineView;

@property (nonatomic, copy) void(^firstBtnBlock)();
@property (nonatomic, copy) void(^secondBtnBlock)();
@property (nonatomic, copy) void(^thirdBtnBlock)();


@property (nonatomic, strong) IWHealhFileModel *model;
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;









@end
