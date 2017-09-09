//
//  IWStatusCompanyParam.h
//  Conedot
//
//  Created by 范超 on 14-10-14.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWStatusCompanyParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  关注 ID
 */
@property (nonatomic, strong) NSNumber *fansId;

/**
 *  关注状态(1:关注;0:取消关注)
 */
@property (nonatomic, assign) int usingStatus;
@end
