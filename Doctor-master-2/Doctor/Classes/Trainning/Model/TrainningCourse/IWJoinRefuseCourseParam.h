//
//  IWJoinRefuseCourseParam.h
//  Conedot
//
//  Created by 范超 on 16/7/10.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWJoinRefuseCourseParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 * 培训课程  ID
 */
@property (nonatomic, copy) NSString *classId;

/**
 * 拒绝(0) 参加(1)
 */
@property (nonatomic, assign) int type;
@end
