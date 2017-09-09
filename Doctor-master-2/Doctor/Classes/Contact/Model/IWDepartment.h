//
//  IWDepartment.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDepartment : NSObject

/**
 *  部门ID
 */
@property (nonatomic, copy) NSString *deptId;

/**
 *  部门名称
 */
@property (nonatomic, copy) NSString *deptName;

/**
 *  父部门 ID
 */
@property (nonatomic, copy) NSString *deptParentId;

/**
 *  部门描述名
 */
@property (nonatomic, copy) NSString *deptRemarkName;

@end
