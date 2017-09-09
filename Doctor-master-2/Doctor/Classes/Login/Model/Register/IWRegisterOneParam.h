//
//  IWRegisterOneParam.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <Foundation/Foundation.h>

@interface IWRegisterOneParam : NSObject
/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  验证码
 */
@property (nonatomic, copy) NSString *securityCode;
@end
