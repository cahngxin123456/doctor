//
//  IWCompanyDetailViewController.h
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWCompany, IWFanCompany, IWNews;

@interface IWCompanyDetailViewController : UIViewController
@property (nonatomic, strong) IWCompany *company;
@property (nonatomic, strong) IWFanCompany *fanCompany;
/**
 *  通知
 */
@property (nonatomic, copy) NSString *noticeId;

/**
 *  新闻
 */
@property (nonatomic, copy) NSString *newsId;

/**
 *  政策
 */
@property (nonatomic, copy) NSString *policyId;

/**
 *  反馈
 */
@property (nonatomic, copy) NSString *feedbackId;

/**
 *  培训体系
 */
@property (nonatomic, copy) NSString *trainningSystemId;
@property (nonatomic, copy) NSString *learnTaskId;

/**
 *  活动详情
 */
@property (nonatomic, copy) NSString *activityId;

/**
 *  通用id
 */
@property (nonatomic, copy) NSString *ID;

@property (nonatomic, strong) IWNews *news;
@end
