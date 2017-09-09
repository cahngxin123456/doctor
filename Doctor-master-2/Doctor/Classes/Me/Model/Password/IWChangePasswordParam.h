//
//  IWChangePasswordParam.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWChangePasswordParam : NSObject
/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  原密码(MD5)
 */
@property (nonatomic, copy) NSString *pwd;

/**
 *  新密码(MD5)
 */
@property (nonatomic, copy) NSString *pwdNew;
@end
