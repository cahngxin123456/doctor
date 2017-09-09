//
//  IWTrainningTool.h
//  Conedot
//
//  Created by 范超 on 15/1/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWTrainningParam.h"
#import "IWTrainningResult.h"
#import "IWTrainningManagerParam.h"
#import "IWTrainningCourseParam.h"
#import "IWTrainningCourseResult.h"
#import "IWJoinRefuseCourseParam.h"

@interface IWTrainningTool : NSObject
/**
 *  加载培训中心的培训体系数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)trainningSystemWithParam:(IWTrainningParam *)param success:(void (^)(IWTrainningResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载我的学习的数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)trainningManagerSystemWithParam:(IWTrainningManagerParam *)param success:(void (^)(IWTrainningResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载course
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)trainningManagerCourseWithParam:(IWTrainningCourseParam *)param success:(void (^)(IWTrainningCourseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  参加course
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)joinRefuseCouseWithParams:(IWJoinRefuseCourseParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error)) failure;

@end
