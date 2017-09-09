//
//  IWMyDoctorViewCell.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <UIKit/UIKit.h>
@class IWMyDoctor;

@interface IWMyDoctorViewCell : UITableViewCell
@property (nonatomic, strong) IWMyDoctor *myDoctor;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
