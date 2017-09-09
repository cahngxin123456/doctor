//
//  IWAddress.h
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAddress : NSObject
/**
 * 主键(仅当 type=database 时包含此值)
 */
@property (nonatomic, copy) NSString *ID;

/**
 * 区域编码
 */
@property (nonatomic, copy) NSString *regionCode;

/**
 * 区域名称
 */
@property (nonatomic, copy) NSString *regionName;

/**
 * 区域级别
 */
@property (nonatomic, copy) NSString *regionLevel;

/**
 * 上级区域编码
 */
@property (nonatomic, copy) NSString *parentCode;

/**
 * 区号
 */
@property (nonatomic, copy) NSString *areaCode;

@property (nonatomic, copy) NSString *cpfAddress;
@property (nonatomic, copy) NSString *socialSecurity;


@end
