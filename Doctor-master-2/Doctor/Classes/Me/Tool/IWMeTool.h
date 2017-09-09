//
//  IWMeTool.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWMeParam.h"
#import "IWChangePasswordParam.h"
#import "IWBaseResult.h"
#import "IWChangePasswordParam.h"
#import "IWStatusCompanyParam.h"
#import "IWChangeCellPhoneParam.h"
#import "IWNotificationParam.h"
#import "IWNotificationResult.h"
#import "IWNotificationKnownParam.h"
#import "IWHelpParam.h"
#import "IWHelpResult.h"
#import "IWUserFeedbackParam.h"
#import "IWUserFeedbackResult.h"
#import "IWHelpDetailParam.h"
#import "IWHelpDetailResult.h"

@interface IWMeTool : NSObject

+ (void)updateIconWithParams:(IWMeParam *)param data:(NSData *)data success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  修改个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)changeUserInfoWithParam:(IWMeParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  修改密码
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)changePasswordInfoWithParam:(IWChangePasswordParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  修改关联公司
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)changeStatusCompanyWithParam:(IWStatusCompanyParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  修改手机号
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)changeCellPhoneWithParam:(IWChangeCellPhoneParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载信息数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)notificationWithParam:(IWNotificationParam *)param success:(void (^)(IWNotificationResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  读取单条信息数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)notificationKnownWithParam:(IWNotificationKnownParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取帮助列表信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)helpWithParam:(IWHelpParam *)param success:(void (^)(IWHelpResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取帮助详情信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)helpDetailWithParam:(IWHelpDetailParam *)param success:(void (^)(IWHelpDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  用户反馈
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userFeedbackSubmitWithParam:(IWUserFeedbackParam *)param success:(void (^)(IWUserFeedbackResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  用户反馈带图片
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
  */
+ (void)userFeedbackSubmitWithParam:(IWUserFeedbackParam *)param path:(NSString *)path success:(void (^)(IWUserFeedbackResult *result))success failure:(void (^)(NSError *error))failure;
@end
