//
//  IWInquiryFirstViewCell.h
//  Doctor
//
//  Created by 雷王 on 17/1/9.
//
//

#import <UIKit/UIKit.h>
@class IWInquiry;

@interface IWInquiryFirstViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWInquiry *inqurity;
@property (nonatomic, assign) int statusType;
@property (nonatomic) CGFloat cellHeight;

@end
