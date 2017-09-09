//
//  IWCompanDetailResult.h
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBaseResult.h"
@class IWDetailExtendInfo;

@interface IWCompanyDetailResult : IWBaseResult
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  内容
 */
@property (nonatomic, copy) NSString *content;

/**
 *  图片列表
 */
@property (nonatomic, strong) NSArray *listImg;

/**
 *  回复内容
 */
@property (nonatomic, copy) NSString *reply;

/**
 *  工具条的标示
 */
@property (nonatomic, strong) IWDetailExtendInfo *extendInfo;

+ (instancetype)companyDetailWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
