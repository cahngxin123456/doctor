//
//  IWBanner.m
//  Conedot
//
//  Created by 范超 on 14-10-22.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBanner.h"

@implementation IWBanner
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (NSString *)url {
    return [_thumb stringByReplacingOccurrencesOfString:@".thumb.jpg" withString:@""];
}
@end
