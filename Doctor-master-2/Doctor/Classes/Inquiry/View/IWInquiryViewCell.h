//
//  IWInquiryViewCell.h
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import <UIKit/UIKit.h>
@class IWInquiry;

@interface IWInquiryViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWInquiry *inqurity;
@property (nonatomic, assign) int statusType;

@end
