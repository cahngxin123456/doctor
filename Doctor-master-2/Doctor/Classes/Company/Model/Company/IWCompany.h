//
//  IWCompany.h
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCompany : NSObject
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  公司 ID
 */
@property (nonatomic, assign) long companyId;

/**
 *  公司名称
 */
@property (nonatomic, copy) NSString *companyName;

/**
 *  公司头像
 */
@property (nonatomic, copy) NSString *photo;

/**
 *  公司昵称
 */
@property (nonatomic, copy) NSString *nickname;

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
 *  类目
 */
@property (nonatomic, copy) NSString *category;

/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *insertTime;

/**
 *  返回所需要的分类名
 */
- (NSString *)categoryName;

/**
 *  返回需要显示的title
 */
- (NSString *)title;
@end
