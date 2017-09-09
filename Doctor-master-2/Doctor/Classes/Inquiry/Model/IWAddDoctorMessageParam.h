//
//  IWAddDoctorMessageParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/8.
//
//

#import <Foundation/Foundation.h>

@interface IWAddDoctorMessageParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;


@property (nonatomic, copy) NSString *inquiryId;
@property (nonatomic, copy) NSString *inquiryAddId; // 留言追加信息 ID(对 追加留言医生的回复 进行评价时须传入此 参数)
@property (nonatomic, copy) NSString *judgement;
@end
