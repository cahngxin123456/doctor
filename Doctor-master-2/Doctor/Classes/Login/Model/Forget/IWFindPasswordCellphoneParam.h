//
//  IWFindPasswordCellphoneParam.h
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWFindPasswordCellphoneParam : NSObject
/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  新密码(MD5)
 */
@property (nonatomic, copy) NSString *pwdNew;

/**
 *  验证码(MD5)
 */
@property (nonatomic, copy) NSString *securityCode;
@end
