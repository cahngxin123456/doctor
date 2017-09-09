//
//  NSString+IW.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (IW)


/**
 *  获取字符长度
 *
 *  @param text 字符串
 *
 *  @return 长度
 */
+ (NSUInteger)unicodeLengthOfString:(NSString *)text;

/**
 *  MD5加密之后的字符串
 *
 *  @param str 需要加密的字符串
 *
 *  @return 加密之后的字符串
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  是否为手机号码
 *
 *  @param mobile 手机号码
 *
 *  @return true:为手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 *  邮箱
 *
 *  @param email 邮箱
 *
 *  @return true:邮箱正确
 */
+ (BOOL)validateEmail:(NSString *)email;
@end
