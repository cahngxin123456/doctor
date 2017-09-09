//
//  IWHelp.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHelp.h"
#import "MJExtension.h"

@implementation IWHelp
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
