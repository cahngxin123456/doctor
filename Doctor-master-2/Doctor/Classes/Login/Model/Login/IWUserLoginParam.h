//
//  IWUserLoginParam.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUserLoginParam : NSObject
/**
 *  登录名|手机号码|邮箱
 */
@property (nonatomic, copy) NSString *loginName;
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
