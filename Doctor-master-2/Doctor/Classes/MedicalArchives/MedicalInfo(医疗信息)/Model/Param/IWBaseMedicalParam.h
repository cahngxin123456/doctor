//
//  IWBaseMedicalParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import <Foundation/Foundation.h>

@interface IWBaseMedicalParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;
@end
