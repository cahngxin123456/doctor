//
//  IWFeedbackDetailViewController.h
//  Conedot
//
//  Created by 范超 on 15/3/11.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWFanCompany, IWNews;

@interface IWFeedbackDetailViewController : UIViewController
/**
 *  反馈
 */
@property (nonatomic, copy) NSString *feedbackId;

/**
 *  关注公司
 */
@property (nonatomic, strong) IWFanCompany *company;

/**
 *  关键字，title
 */
@property (nonatomic, strong) IWNews *news;
@end
