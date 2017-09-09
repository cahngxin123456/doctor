//
//  IWGetMedicalReportDetailResult.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWBaseResult.h"
#import "IWMedicalReport.h"

@interface IWGetMedicalReportDetailResult : IWBaseResult
@property (nonatomic, strong) IWMedicalReport *datas;
@end
