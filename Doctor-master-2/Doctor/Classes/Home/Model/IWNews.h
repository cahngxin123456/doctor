//
//  IWNews.h
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWNews : NSObject
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  概要
 */
@property (nonatomic, copy) NSString *overview;

/**
 *  类目(notice 通知 news 新闻 policy 政策)
 */
@property (nonatomic, copy) NSString *category;

/**
 *  缩略图
 */
@property (nonatomic, copy) NSString *thumb;
/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *insertTime;

/**
 *  关键字
 */
@property (nonatomic, copy) NSString *keywords;

/**
 *  状态
 */
@property (nonatomic, copy) NSString *usingStatus2show;

/**
 *  读取状态 0 未读 1 已读
 */
@property (nonatomic, assign) int readStatus;


/**
 *  学习状态 0 未学 1 已学
 */
@property (nonatomic, assign) int learnStatus;

@end
