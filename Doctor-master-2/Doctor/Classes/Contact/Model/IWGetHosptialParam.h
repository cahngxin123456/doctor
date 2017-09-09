//
//  IWGetHosptialParam.h
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import <Foundation/Foundation.h>

@interface IWGetHosptialParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, copy) NSNumber *companyId;


/**
 *  若为子,此项必填
 */
@property (nonatomic, copy) NSString *hospitalId;
@end
