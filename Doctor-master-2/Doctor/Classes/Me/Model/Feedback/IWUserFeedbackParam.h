//
//  IWUserFeedbackParam.h
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUserFeedbackParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  内容
 */
@property (nonatomic, copy) NSString *content;


/**
 *  联系方式
 */
@property (nonatomic, copy) NSString *contact;

@end
