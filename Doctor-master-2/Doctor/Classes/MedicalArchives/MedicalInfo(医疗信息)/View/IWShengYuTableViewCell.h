//
//  IWShengYuTableViewCell.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>
#import "IWShengYu.h"

@interface IWShengYuTableViewCell : UITableViewCell

@property (nonatomic, strong) IWShengYu *shengyuModel;
@property (nonatomic, weak) UILabel *sexLabel;
@property (nonatomic, weak) UILabel *timeLabel;

@property (nonatomic, weak) UIButton *resultButton;
@property (nonatomic, weak) UIButton *manButton;
@property (nonatomic, weak) UIButton *womenButton;
@property (nonatomic, weak) UIButton *firstButton;
@property (nonatomic, weak) UIButton *secondButton;
@property (nonatomic, weak) UIButton *thirdButton;

@property (nonatomic, copy) void(^resultButtonBlock)(NSIndexPath *index);
@property (nonatomic, copy) void(^personBlock)(NSIndexPath *index,NSInteger tag);
@property (nonatomic, copy) void(^typeBlock)(NSIndexPath *index,NSInteger tag);



@property (nonatomic, weak) UIButton *personSelectedbtn;
@property (nonatomic, weak) UIButton *typeSelectedBtn;
@property (nonatomic, weak) UIImageView *arrowImageview;

@property (nonatomic, strong) NSIndexPath *index;




+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;


@end
