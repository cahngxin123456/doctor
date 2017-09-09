//
//  IWFanCompany.h
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWFanCompany : NSObject <NSCoding>


/**
 *  关注ID
 */
@property (nonatomic, assign) long ID;

/**
 *  人员 ID
 */
@property (nonatomic, assign) long userId;

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
@property (nonatomic, copy) NSString *companyPhoto;

/**
 *  公司昵称
 */
@property (nonatomic, copy) NSString *companyNickname;

/**
 *  关注状态
 * 0:待关注 1:已关注
 */
@property (nonatomic, assign) long usingStatus;

/**
 *  关注状态
 */
@property (nonatomic, copy) NSString *usingStatus2show;

@end
