//
//  IWCourse.h
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCourse : NSObject
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
 *  课时 ID
 */
@property (nonatomic, copy) NSString *classInfoId;

/**
 *  课时标题
 */
@property (nonatomic, copy) NSString *classInfoTitle;

/**
 *  培训地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *  开始时间
 */
@property (nonatomic, copy) NSString *startTime;

/**
 *  结束时间
 */
@property (nonatomic, copy) NSString *endTime;

/**
 *  讲师
 */
@property (nonatomic, copy) NSString *teacher;

@end
