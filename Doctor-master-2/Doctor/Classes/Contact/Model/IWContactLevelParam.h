//
//  IWContactLevelParam.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWContactLevelParam : NSObject

/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, copy) NSNumber *companyId;


/**
 *  部门 ID(若为子部门,此项必填)
 */
@property (nonatomic, copy) NSString *deptId;


/**
 *  员工名称
 */
@property (nonatomic, copy) NSString *username;

@end
