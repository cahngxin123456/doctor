//
//  IWBanner.h
//  Conedot
//
//  Created by 范超 on 14-10-22.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBanner : NSObject
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  显示对象 id
 */
@property (nonatomic, copy) NSString *objectId;

/**
 *  显示对象类型(news 新闻 policy 政策 travor 天斡新闻 birthdayWishes 生日祝福)
 */
@property (nonatomic, copy) NSString *objectType;

/**
 *  图片 url
 */
@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *defaultId;

- (NSString *)url;

@end
