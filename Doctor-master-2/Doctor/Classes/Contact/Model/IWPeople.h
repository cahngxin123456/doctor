//
//  IWPeople.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWPeople : NSObject

@property (nonatomic, copy) NSString *hospitalId; // 员工ID
@property (nonatomic, copy) NSString *hospitalName; // 员工名称
@property (nonatomic, copy) NSString *communityId; // 部门ID
@property (nonatomic, copy) NSString *communityName; // 部门名称

/**
 *  员工ID
 */
@property (nonatomic, copy) NSString *userId;

/**
 *  员工名称
 */
@property (nonatomic, copy) NSString *userName;

/**
 *  部门ID
 */
@property (nonatomic, copy) NSString *deptId;

/**
 *  部门
 */
@property (nonatomic, copy) NSString *deptName;

/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *mail;

/**
 *  电话 1
 */
@property (nonatomic, copy) NSString *telephone1;

/**
 *  电话 2
 */
@property (nonatomic, copy) NSString *telephone2;

/**
 *  电话 3
 */
@property (nonatomic, copy) NSString *telephone3;

/**
 *  公司 ID
 */
@property (nonatomic, copy) NSString *companyId;

/**
 *  公司
 */
@property (nonatomic, copy) NSString *companyName;

/**
 *  照片路径
 */
@property (nonatomic, copy) NSString *photo;

/**
 *  员工编号
 */
@property (nonatomic, copy) NSString *userCode;

/**
 *  员工职务
 */
@property (nonatomic, copy) NSString *userDuty;

/**
 *  性别
 */
@property (nonatomic, copy) NSNumber *gender;


@property (nonatomic, strong) NSArray *phones; // 所有有电话的集合
@end
