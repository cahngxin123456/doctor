//
//  IWBaseResult.h
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBaseResult : NSObject
/**
 *  返回代码
 * -1 请求异常,服务器出现未知异常时。
 * 0 请求成功。
 * 1 请求失败,请求参数有误时。
 * 1000 接口已停用。
 * 1003 登录名未被注册过。
 * 1004 账号已锁定。
 * 1005 账号状态异常。
 * 1006 密码输入有误。
 */
@property (nonatomic, assign) long code;

/**
 *  登录信息
 */
@property (nonatomic, copy) NSString *info;

@end
