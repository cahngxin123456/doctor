//
//  IWHelpParam.h
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHelpParam : NSObject
/**
 *  登录 ID
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
