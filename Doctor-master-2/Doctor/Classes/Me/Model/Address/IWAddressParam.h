//
//  IWAddressParam.h
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAddressParam : NSObject

/**
 * 区域列表类型 all:所有下级 province:省级 city:市级 county:县级
 */
@property (nonatomic, copy) NSString *listType;

/**
 * 父区域编码
 */
@property (nonatomic, copy) NSString *parentCode;

/**
 * 类型(默认 cache) cache-缓存中获取 database-数据库中获取
 */
@property (nonatomic, copy) NSString *type;

@end
