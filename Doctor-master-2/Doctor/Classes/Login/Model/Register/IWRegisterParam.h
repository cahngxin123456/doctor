//
//  IWRegisterParam.h
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWRegisterParam : NSObject

/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  登录名|手机号码|邮箱
 */
@property (nonatomic, copy) NSString *loginName;

/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *mail;

/**
 *  密码(MD5)
 */
@property (nonatomic, copy) NSString *pwd;


/**
 *  渠道(例:IOS-7.1-V1.1.0)
 */
@property (nonatomic, copy) NSString *channel;

/**
 *  设备号
 */
@property (nonatomic, copy) NSString *deviceToken;
@end
