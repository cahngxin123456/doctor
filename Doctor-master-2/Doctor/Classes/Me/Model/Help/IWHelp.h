//
//  IWHelp.h
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHelp : NSObject
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

@end
