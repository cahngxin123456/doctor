//
//  IWFanCompany.m
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFanCompany.h"

@implementation IWFanCompany

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.ID = [decoder decodeInt64ForKey:@"ID"];
        self.userId = [decoder decodeInt64ForKey:@"userId"];
        self.companyId = [decoder decodeInt64ForKey:@"companyId"];
        self.companyName = [decoder decodeObjectForKey:@"companyName"];
        self.companyPhoto = [decoder decodeObjectForKey:@"companyPhoto"];
        self.companyNickname = [decoder decodeObjectForKey:@"companyNickname"];
        self.usingStatus = [decoder decodeInt64ForKey:@"usingStatus"];
        self.usingStatus2show = [decoder decodeObjectForKey:@"usingStatus2show"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt64:self.ID forKey:@"ID"];
    [encoder encodeInt64:self.userId forKey:@"userId"];
    [encoder encodeInt64:self.companyId forKey:@"companyId"];
    [encoder encodeObject:self.companyName forKey:@"companyName"];
    [encoder encodeObject:self.companyPhoto forKey:@"companyPhoto"];
    [encoder encodeObject:self.companyNickname forKey:@"companyNickname"];
    [encoder encodeInt64:self.usingStatus forKey:@"usingStatus"];
    [encoder encodeObject:self.usingStatus2show forKey:@"usingStatus2show"];
}

/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

@end
