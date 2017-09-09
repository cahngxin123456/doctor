//
//  IWDeleteMedicalReportParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import <Foundation/Foundation.h>

@interface IWDeleteMedicalReportParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 * 病历报告 ID
 */
@property (nonatomic, copy) NSString *reportId;
@end
