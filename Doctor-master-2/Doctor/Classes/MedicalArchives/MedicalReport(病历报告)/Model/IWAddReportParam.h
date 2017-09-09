//
//  IWAddReportParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/2.
//
//

#import <Foundation/Foundation.h>

@interface IWAddReportParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 * 报告类型(0 体检报 告 1 门诊病历 2 住 院病历 3 诊断处方)
 */
@property (nonatomic, assign) int reportType;


/**
 *  报告日期
 */
@property (nonatomic, copy) NSString *reportDate;

/**
 *  医疗机构
 */
@property (nonatomic, copy) NSString *hospital;

/**
 *  疾病名称
 */
@property (nonatomic, copy) NSString *disease;

/**
 *  问题描述
 */
@property (nonatomic, copy) NSString *remark;

@property (nonatomic, copy) NSString *memberId;
@property (nonatomic, copy) NSString *reportId;

/**
 *  修改时删除网络图片时
 */
@property (nonatomic, copy) NSString *deletePic;
@end
