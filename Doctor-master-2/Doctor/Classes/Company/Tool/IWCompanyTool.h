//
//  IWCompanyTool.h
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWRelateCompanyParam.h"
#import "IWRelateCompanyResult.h"
#import "IWCompanyDetailParam.h"
#import "IWCompanyDetailResult.h"
#import "IWCompanyFanParam.h"
#import "IWCompanyFanResult.h"
#import "IWCompanyUnReadParam.h"
#import "IWCompanyUnReadResult.h"

@class IWFanCompany;

@interface IWCompanyTool : NSObject

/**
 *  存储当前所有关注的公司信息
 *
 *  @param user 当前关注的公司信息
 */
+ (void)saveFanCompanys:(NSArray *)fancompanys;

/**
 *  返回所有关注的公司信息
 */
+ (NSArray *)fancompanys;

/**
 *  存储当前关注的公司信息
 *
 *  @param user 当前关注的公司信息
 */
+ (void)saveFanCompany:(IWFanCompany *)fancompany;

/**
 *  返回存储的公司信息
 */
+ (IWFanCompany *)fancompany;

/**
 *  移除公司信息
 */
+ (void)removeFancompany;

/**
 *  加载所有公司关联的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyRelateWithParam:(IWRelateCompanyParam *)param success:(void (^)(IWRelateCompanyResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载公司的详情
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyDetailWithParam:(IWCompanyDetailParam *)param success:(void (^)(IWCompanyDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  公司报名
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyApplyWithParam:(IWCompanyDetailParam *)param success:(void (^)(IWCompanyDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  公司已知道
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyKnownWithParam:(IWCompanyDetailParam *)param success:(void (^)(IWCompanyDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  公司赞
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companySignUpWithParam:(IWCompanyDetailParam *)param success:(void (^)(IWCompanyDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  公司评论
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyCommentWithParam:(IWCompanyDetailParam *)param success:(void (^)(IWCompanyDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取所有得公司
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)companyFanWithParam:(IWCompanyFanParam *)param success:(void (^)(IWCompanyFanResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取公司未读数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)unReadNumberWithParam:(IWCompanyUnReadParam *)param success:(void (^)(IWCompanyUnReadResult *result))success failure:(void (^)(NSError *error))failure;

@end
