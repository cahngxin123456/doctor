//
//  IWMedicalMointorSugarTableViewCell.h
//  Doctor
//
//  Created by 雷王 on 17/1/7.
//
//

#import <UIKit/UIKit.h>
#import "IWBloodSugerModel.h"
@interface IWMedicalMointorSugarTableViewCell : UITableViewCell
//时间
@property (nonatomic,strong) UILabel *lbOfTime;
//餐
@property (nonatomic,strong) UILabel *lbOfEat;
//血糖含量
@property (nonatomic,strong) UILabel *lbOfMedicalNumber;
//血糖单位
@property (nonatomic,strong) UILabel *lbOfMedicalM;
//血糖的超出还是低于
@property (nonatomic,strong) UILabel *lbOfMedical;
//血糖的标准
@property (nonatomic,strong) UIView *viewOfMedical;

//备注
@property (nonatomic,strong) UILabel *lbOfRemark;
//备注内容
@property (nonatomic,strong) UILabel *lbOfRemarkContent;
//备注分割
@property (nonatomic,strong) UILabel *lbOfSeprateRemark;
//cell分割
@property (nonatomic,strong) UILabel *lbOfSeprate;

//cell的数据
@property (nonatomic,strong) IWBloodSugerModel *model;
//初始化方法
+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView;

@end
