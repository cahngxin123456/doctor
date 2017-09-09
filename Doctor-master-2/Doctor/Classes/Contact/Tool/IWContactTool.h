//
//  IWContactTool.h
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWContactParam.h"
#import "IWContactResult.h"
#import "IWContactLevelParam.h"
#import "IWContactLevelResult.h"
#import "IWCommonContactResult.h"
#import "IWGetCommunityParam.h"
#import "IWGetCommunityResult.h"
#import "IWGetHosptialParam.h"
#import "IWGetHospitalContactResult.h"

@interface IWContactTool : NSObject

/**
 * 保存title
 */
+ (void)saveTopTitle:(NSString *)title;

/**
 * 显示title
 */
+ (NSString *)topTitle;

/**
 * 清空title
 */
+ (void)removeTopTitle;


/**
 *  修改关联公司
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)contactWithParam:(IWContactParam *)param success:(void(^)(IWContactResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取联系人
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getCommunityList:(IWGetCommunityParam *)param success:(void(^)(IWGetCommunityResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取联系人
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getHospitalList:(IWGetHosptialParam *)param success:(void(^)(IWGetHospitalContactResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取联系人
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)departmentWithParam:(IWContactLevelParam *)param success:(void(^)(IWContactLevelResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取常用联系人
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调  
 */
+ (void)commonContactWithParam:(IWContactParam *)param success:(void(^)(IWCommonContactResult *result))success failure:(void (^)(NSError *error))failure;
@end
