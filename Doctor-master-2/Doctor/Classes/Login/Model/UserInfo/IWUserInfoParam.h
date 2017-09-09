//
//  IWUserInfoParam.h
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUserInfoParam : NSObject
/**
 *  登录名|手机号码|邮箱
 */
@property (nonatomic, copy) NSString *loginName;

/**
 *  密码(MD5)
 */
@property (nonatomic, copy) NSString *pwd;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

@end
