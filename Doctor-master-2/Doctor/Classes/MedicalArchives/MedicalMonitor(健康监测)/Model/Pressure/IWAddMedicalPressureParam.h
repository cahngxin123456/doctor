//
//  IWAddMedicalPressureParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import <Foundation/Foundation.h>

@interface IWAddMedicalPressureParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;


/**
 *  高压
 */
@property (nonatomic, copy) NSString *highPresure;

/**
 *  低压
 */
@property (nonatomic, copy) NSString *lowPressure;

/**
 *  心率
 */
@property (nonatomic, copy) NSString *heartRate;

/**
 *  测量时间
 */
@property (nonatomic, copy) NSString *measureTime;

/**
 *  备注
 */
@property (nonatomic, copy) NSString *remark;

/**
 *  memberId
 */
@property (nonatomic, copy) NSString *memberId;

/**
 *  修改时 Id
 */
@property (nonatomic, copy) NSString *pressureId;
@end
