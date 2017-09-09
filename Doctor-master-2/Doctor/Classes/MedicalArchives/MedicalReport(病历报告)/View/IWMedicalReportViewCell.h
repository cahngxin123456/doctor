//
//  IWMedicalReportViewCell.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <UIKit/UIKit.h>
#import "IWMedicalReport.h"
#import "IWInquiry.h"

@protocol IWMedicalReportViewCellDelegate <NSObject>

- (void)didClickDeleteButton:(IWMedicalReport *)medicalReport;
- (void)didClickCheckBoxButton:(IWMedicalReport *)medicalReport;

@end

@interface IWMedicalReportViewCell : UITableViewCell

@property (nonatomic, weak) id<IWMedicalReportViewCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) IWMedicalReport *medicalReport;
@property (nonatomic, assign) BOOL isFromInquiry;



@end
