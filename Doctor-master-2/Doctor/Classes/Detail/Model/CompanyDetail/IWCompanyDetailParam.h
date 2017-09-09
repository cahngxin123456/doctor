//
//  IWCompanyDetailParam.h
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCompanyDetailParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 *  新闻 ID
 */
@property (nonatomic, copy) NSString *newsId;

/**
 *  通知 ID
 */
@property (nonatomic, copy) NSString *noticeId;

/**
 *  政策 ID
 */
@property (nonatomic, copy) NSString *policyId;

/**
 *  反馈 ID
 */
@property (nonatomic, copy) NSString *feedbackId;

/**
 *  评论用的内容
 */
@property (nonatomic, copy) NSString *review;

/**
 *  培训体系 ID
 */
@property (nonatomic, copy) NSString *manualId;

/**
 *  培训体系 ID
 */
@property (nonatomic, copy) NSString *learnTaskId;

/**
 *  活动 ID
 */
@property (nonatomic, copy) NSString *activityId;

/**
 *  type
 */
@property (nonatomic, copy) NSString *type;
@end
