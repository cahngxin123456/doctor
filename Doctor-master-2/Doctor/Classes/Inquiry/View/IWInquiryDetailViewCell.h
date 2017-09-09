//
//  IWInquiryDetailViewCell.h
//  Doctor
//
//  Created by 范超 on 2017/1/8.
//
//

#import <UIKit/UIKit.h>
@class IWGetInquiryDetail, IWMedicalReport;

@protocol IWInquiryDetailViewCellDelegate <NSObject>

- (void)didClickLoadButton:(IWMedicalReport *)report;

@end

@interface IWInquiryDetailViewCell : UITableViewCell

@property (nonatomic, weak) id<IWInquiryDetailViewCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) IWGetInquiryDetail *detail;

@property (nonatomic, copy) void(^evaluateDoctorButtonBlock)();


@end
