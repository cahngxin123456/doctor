//
//  IWNotification.h
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWNotification : NSObject

/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *insertTime;

/**
 *  在用状态
 */
@property (nonatomic, assign) int status;

/**
 *  在用状态
 */
@property (nonatomic, copy) NSString *usingStatus2show;
@end
