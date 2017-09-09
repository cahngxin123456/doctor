//
//  IWChangeCellPhoneParam.h
//  Conedot
//
//  Created by 范超 on 14-10-16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWChangeCellPhoneParam : NSObject

/**
 *  登录名|手机号码|邮箱
 */
@property (nonatomic, copy) NSString *loginName;

/**
 *  密码(MD5)
 */
@property (nonatomic, copy) NSString *pwd;
/**
 *  新手机号码
 */
@property (nonatomic, copy) NSString *cellphoneNew;

/**
 *  验证码(MD5)
 */
@property (nonatomic, copy) NSString *securityCode;

@end
