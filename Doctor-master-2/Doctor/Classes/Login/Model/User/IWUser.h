//
//  IWUser.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUser : NSObject <NSCoding>
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;
/**
 *  登录名
 */
@property (nonatomic, copy) NSString *loginName;
/**
 *  密码
 */
@property (nonatomic, copy) NSString *pwd; // 加密的
@property (nonatomic, copy) NSString *password; // 未加密的

/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *mail;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *userName;

/**
 *  社区
 */
@property (nonatomic, copy) NSString *communityId;
@property (nonatomic, copy) NSString *communityName;

/**
 *  身份证号
 */
@property (nonatomic, copy) NSString *userCard;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *photo;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;
/**
 *  性别
 */
@property (nonatomic, assign) NSInteger gender;
/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender2show;
/**
 *  出生日期
 */
@property (nonatomic, copy) NSString *birthday;
/**
 *  出生地
 */
@property (nonatomic, copy) NSString *birthplace;
/**
 *  出生地
 */
@property (nonatomic, copy) NSString *birthplace2show;
/**
 *  民族
 */
@property (nonatomic, copy) NSString *nation;
/**
 *  民族
 */
@property (nonatomic, copy) NSString *nation2show;
/**
 *  婚姻状态
 */
@property (nonatomic, copy) NSString *maritalStatus;
/**
 *  婚姻状态
 */
@property (nonatomic, copy) NSString *maritalStatus2show;
/**
 *  学历
 */
@property (nonatomic, copy) NSString *education;
/**
 *  学历
 */
@property (nonatomic, copy) NSString *education2show;
/**
 *  学位
 */
@property (nonatomic, copy) NSString *degree;
/**
 *  学位
 */
@property (nonatomic, copy) NSString *degree2show;

/**
 * 公积金地址
 */
@property (nonatomic, copy) NSString *cpf;
/**
 *  五险地址
 */
@property (nonatomic, copy) NSString *socialSecurity;

/**
 * DeviceToken
 */
@property (nonatomic, copy) NSString *deviceToken;

- (BOOL) isMale;

@end
