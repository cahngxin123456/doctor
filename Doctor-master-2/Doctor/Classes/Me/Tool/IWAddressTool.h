//
//  IWAddressTool.h
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWAddressParam.h"
#import "IWAddressResult.h"

@interface IWAddressTool : NSObject
/**
 *  获取地理位置
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)addressWithParam:(IWAddressParam *)param success:(void(^)(IWAddressResult *result))success failure:(void (^)(NSError *error))failure;
@end
