//
//  IWAppMenu.m
//  Conedot
//
//  Created by 范超 on 15/9/13.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWAppMenu.h"
#import "MJExtension.h"

@implementation IWAppMenu
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
