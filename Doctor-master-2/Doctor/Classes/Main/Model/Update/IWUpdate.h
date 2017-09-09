//
//  IWUpdate.h
//  Conedot
//
//  Created by 范超 on 15/4/3.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUpdate : NSObject

/**
 *  版本号
 */
@property (nonatomic, copy) NSString *version;

/**
 *  安装包地址
 */
@property (nonatomic, copy) NSString *url;

/**
 *  安装包大小
 */
@property (nonatomic, copy) NSString *packageSize;

/**
 *  安装包 MD5 值
 */
@property (nonatomic, copy) NSString *md5;

/**
 *  客服电话
 */
@property (nonatomic, copy) NSString *servicePhone;

/**
 *  更新信息 o zh中文 o en英文
 */
@property (nonatomic, copy) NSDictionary *updateMessage;

@end
