//
//  IWDetailExtendInfo.h
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWDetailExtendInfo : NSObject
/**
 *  报名标示
 */
@property (nonatomic, assign) int applyFlag;

/**
 *  知道标示
 */
@property (nonatomic, assign) int knownFlag;

/**
 *  赞标示
 */
@property (nonatomic, assign) int praizeFlag;

/**
 * 包含读状态 learnStatus 0 未学 1 已学
 */
@property (nonatomic, assign) int learnStatus;

/**
 *  评论
 */
@property (nonatomic, copy) NSString *review;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)extendInfoWithDict:(NSDictionary *)dict;
@end
