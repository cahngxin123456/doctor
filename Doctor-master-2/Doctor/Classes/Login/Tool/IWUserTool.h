//
//  IWUserTool.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWUserLoginParam.h"
#import "IWUserLoginResult.h"
#import "IWRegisterScParam.h"
#import "IWRegisterScResult.h"
#import "IWRegisterParam.h"
#import "IWRegisterResult.h"
#import "IWFindPasswordCellphoneParam.h"
#import "IWFindPasswordEmailParam.h"
#import "IWFindPasswordResult.h"
#import "IWUserInfoParam.h"
#import "IWUserInfoResult.h"
#import "IWResetCellphoneParam.h"
#import "IWRegisterOneParam.h"

@class IWUser;

@interface IWUserTool : NSObject

/**
 *  用户登录
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userLoginWithParam:(IWUserLoginParam *)param success:(void(^)(IWUserLoginResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  存储账号信息
 *
 *  @param user 需要存储的账号
 */
+ (void)saveUser:(IWUser *)user;

/**
 *  移除账号信息
 */
+ (void)removeUser;

/**
 *  返回存储的账号信息
 */
+ (IWUser *)user;

/**
 *  存储accesstoken
 *
 *  @param accessToken
 */
+ (void)saveAccessToken:(NSString *)accessToken;


/**
 *  返回存储的accessToken
 */
+ (NSString *)accessToken;

/**
 *  获取验证码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userRegisterScWithParam:(IWRegisterScParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取修改电话号码的验证码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userChangePhoneScWithParam:(IWResetCellphoneParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  执行注册--第一步
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userRegisterOneWithParam:(IWRegisterOneParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  执行注册
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userRegisterWithParam:(IWRegisterParam *)param success:(void(^)(IWRegisterResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取重置密码验证码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userPasswordScWithParam:(IWRegisterScParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  通过电话重置密码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userFindPasswordCellphoneWithParam:(IWFindPasswordCellphoneParam *)param success:(void(^)(IWFindPasswordResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  通过电话重置密码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userFindPasswordEmailWithParam:(IWFindPasswordEmailParam *)param success:(void(^)(IWFindPasswordResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  通过电话重置密码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void(^)(IWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;


@end
