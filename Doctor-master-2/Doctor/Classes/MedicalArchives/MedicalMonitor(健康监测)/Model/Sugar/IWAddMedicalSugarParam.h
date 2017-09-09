//
//  IWAddMedicalBloodParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import <Foundation/Foundation.h>

@interface IWAddMedicalSugarParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;


/**
 *  memberId
 */
@property (nonatomic, copy) NSString *memberId;

/**
 *  时段(空腹 早餐后 午餐前 午餐后 晚餐前 晚餐后)
 */
@property (nonatomic, copy) NSString *period;

/**
 *  血糖值
 */
@property (nonatomic, copy) NSString *bloodSugar;

/**
 *  测量时间
 */
@property (nonatomic, copy) NSString *measureTime;

/**
 *  备注
 */
@property (nonatomic, copy) NSString *remark;

/**
 *  修改时 Id
 */
@property (nonatomic, copy) NSString *sugarId;
@end
