//
//  IWCommonTool.h
//  Conedot
//
//  Created by 范超 on 15/4/3.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWGetVersionParam.h"
#import "IWGetVersionResult.h"
#import "IWReadAllNewsParam.h"

@interface IWCommonTool : NSObject
/**
 *  获取当前版本信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getVersionWithParam:(IWGetVersionParam *)param success:(void(^)(IWGetVersionResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  一键读取所有的新闻
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)readAllNewsWithParam:(IWReadAllNewsParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;


@end
