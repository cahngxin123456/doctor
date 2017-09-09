//
//  IWMeParam.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWMeParam : NSObject

/**
 *  手机号码
 */
@property (nonatomic, copy) NSString *cellphone;

/**
 *  密码
 */
@property (nonatomic, copy) NSString *pwd;

/**
 *  性别(字典 gender)
 */
@property (nonatomic, strong) NSNumber *gender;

/**
 *  出生日期(yyyy-MM-dd)
 */
@property (nonatomic, copy) NSString *birthday;


/**
 *  籍贯(区域编码)
 */
@property (nonatomic, copy) NSString *birthplace;

/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *mail;
@end
