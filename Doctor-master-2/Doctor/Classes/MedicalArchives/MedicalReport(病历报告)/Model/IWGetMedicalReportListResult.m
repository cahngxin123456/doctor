//
//  IWGetMedicalReportResult.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWGetMedicalReportListResult.h"
#import "IWMedicalReport.h"

@implementation IWGetMedicalReportListResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWMedicalReport class]};
}
@end
