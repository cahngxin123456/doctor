//
//  IWUnRead.h
//  Conedot
//
//  Created by 范超 on 15/1/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUnRead : NSObject

/**
 *  新闻未读条数
 */
@property (nonatomic, assign) int newsUnReadNumber;

/**
 *  通知未读条数
 */
@property (nonatomic, assign) int noticeUnReadNumber;

/**
 *  政策未读条数
 */
@property (nonatomic, assign) int policyUnReadNumber;


/**
 *  工资单未读条数
 */
@property (nonatomic, assign) int payslipUnReadNumber;

/**
 *  未答问卷条数
 */
@property (nonatomic, assign) int questionnaireUnReadNumber;

/**
 *  招聘未读数
 */
@property (nonatomic, assign) int recruitUnReadNumber;

/**
 *  审核未读条数
 */
@property (nonatomic, assign) int approvalingNumber;
@property (nonatomic, assign) int approvalCcNumber;
@property (nonatomic, assign) int approvalEndNumber;

// 审核总数
@property (nonatomic, assign) int approvalTotal;

/**
 *  活动未读条数
 */
@property (nonatomic, assign) int activityNumber;

/**
 *  反馈总条数
 */
@property (nonatomic, assign) int feedBackNumber;

/**
 *  投票总条数
 */
@property (nonatomic, assign) int voteNumber;


/**
 *  手册未读条数
 */
@property (nonatomic, assign) int manualUnReadNumber; // 首页上的

@property (nonatomic, assign) int manutalTotalNum;    // 第一个tab
@property (nonatomic, assign) int manualClassUnReadNumber;    // 课程介绍
@property (nonatomic, assign) int manualProjectUnReadNumber;  // 特别项目
@property (nonatomic, assign) int manualQuestionUnReadNumber; // 常见问题
@property (nonatomic, assign) int manualTeacherUnReadNumber;  // 讲师介绍
@property (nonatomic, assign) int manualTrainingUnReadNumber; // 培训体系

@property (nonatomic, assign) int learnTaskNumber;  // 自学任务

/**
 *  总数
 */
- (int)count;

@end
