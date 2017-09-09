//
//  IWPeopleCacheTool.h
//  Conedot
//
//  Created by 范超 on 15/3/9.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IWPeople;

@interface IWPeopleCacheTool : NSObject

/**
 *  删除一位联系人
 *
 *  @param people 需要缓存的人员
 */
+ (void)deletePeople:(IWPeople *)people;

/**
 *  缓存一位联系人
 *
 *  @param people 需要缓存的人员
 */
+ (void)addPeople:(IWPeople *)people;

/**
 *  获取所有存储的联系人
 *
 *  @return 模型数组
 */
+ (NSArray *)peoples;

@end
