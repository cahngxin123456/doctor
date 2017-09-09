//
//  IWNotificationKnownParam.h
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWNotificationKnownParam : NSObject
/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  消息 ID
 */
@property (nonatomic, copy) NSString *notificationId;
@end
