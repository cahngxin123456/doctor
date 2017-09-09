//
//  IWFeedbackSubmitParam.h
//  Conedot
//
//  Created by 范超 on 14-10-13.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWFeedbackSubmitParam : NSObject

/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  内容
 */
@property (nonatomic, copy) NSString *content;

/**
 *  关键字
 */
@property (nonatomic, copy) NSString *keywords;

@end
