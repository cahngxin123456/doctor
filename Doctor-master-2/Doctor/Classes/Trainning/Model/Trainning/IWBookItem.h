//
//  IWBookItem.h
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWTrainningParam.h"

@interface IWBookItem : NSObject
/**
 *  名称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  未读数
 */
@property (nonatomic, assign) int unReadnum;

/**
 *  状态
 */
@property (nonatomic, assign, getter=isEnable) BOOL enable;

/**
 *  控制器
 */
@property (nonatomic, copy) NSString *controllerVc;

/**
 *  类型
 */
@property (nonatomic, assign) IWTrainningBookType type;
@end
