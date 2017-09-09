//
//  IWCompanDetailResult.m
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWCompanyDetailResult.h"
#import "IWDetailExtendInfo.h"

@implementation IWCompanyDetailResult
- (NSDictionary *)objectClassInArray {
    return @{@"listImg" : [NSString class]};
}

/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

+ (instancetype)companyDetailWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.ID = dict[@"id"];
        self.title = dict[@"title"];
        self.content = dict[@"content"];
        self.reply = dict[@"reply"];
        
        if ((NSNull *)dict[@"listImg"] == [NSNull null]) {
            self.listImg = nil;
        }
        self.listImg = dict[@"listImg"];
        
        if ([dict[@"extendInfo"] isKindOfClass:[NSString class]]) {
            self.extendInfo = nil;
        } else {
            self.extendInfo = [IWDetailExtendInfo extendInfoWithDict:dict[@"extendInfo"]];
        }
    }
    return self;
}

@end
