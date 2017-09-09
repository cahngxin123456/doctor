//
//  IWMyDoctorParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <Foundation/Foundation.h>

@interface IWMyDoctorParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

@end
