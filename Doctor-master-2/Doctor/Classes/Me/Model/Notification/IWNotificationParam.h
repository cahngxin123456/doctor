//
//  IWNotificationParam.h
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWNotificationParam : NSObject
/**
 *  登录id
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  页码
 */
@property (nonatomic, strong) NSNumber *pageNumber;

/**
 *  页面大小
 */
@property (nonatomic, strong) NSNumber *pageSize;

@end
