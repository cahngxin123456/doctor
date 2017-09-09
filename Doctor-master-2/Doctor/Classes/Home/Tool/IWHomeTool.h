//
//  IWHomeTool.h
//  Conedot
//
//  Created by 范超 on 15/5/22.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWHomeBannerParam.h"
#import "IWHomeBannerResult.h"
#import "IWRemindParam.h"
#import "IWRemindResult.h"

@interface IWHomeTool : NSObject

/**
 *  加载图片banner
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeBannerWithParam:(IWHomeBannerParam *)param success:(void (^)(IWHomeBannerResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取首页数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)remindNumberWithParam:(IWRemindParam *)param success:(void (^)(IWRemindResult *result))success failure:(void (^)(NSError *error))failure;
@end
