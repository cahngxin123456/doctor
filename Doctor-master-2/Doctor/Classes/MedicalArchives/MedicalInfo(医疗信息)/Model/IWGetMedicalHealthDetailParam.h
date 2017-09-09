//
//  IWGetMedicalHealthDetailParam.h IWGetMedicalHealthDetailParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>

@interface IWGetMedicalHealthDetailParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 * ID
 */
@property (nonatomic, copy) NSString *memberId;
@end
