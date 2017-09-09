//
//  IWGetMedicalSugarListParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import <Foundation/Foundation.h>

@interface IWGetMedicalSugarListParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

@property (nonatomic, copy) NSString *memberId;

/**
 *  页码
 */
@property (nonatomic, strong) NSNumber *pageNumber;

/**
 *  页面大小
 */
@property (nonatomic, strong) NSNumber *pageSize;

@end
