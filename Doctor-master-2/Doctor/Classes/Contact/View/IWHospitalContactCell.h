//
//  IWHospitalContactCell.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <UIKit/UIKit.h>
@class IWHospitalContact;

@interface IWHospitalContactCell : UITableViewCell
@property (nonatomic, strong) IWHospitalContact *contact;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
