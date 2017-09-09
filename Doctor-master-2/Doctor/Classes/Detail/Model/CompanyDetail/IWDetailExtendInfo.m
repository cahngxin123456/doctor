//
//  IWDetailExtendInfo.m
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWDetailExtendInfo.h"

@implementation IWDetailExtendInfo

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.applyFlag = [dict[@"joinFlag"] intValue];
        self.knownFlag = [dict[@"knownFlag"] intValue];
        self.praizeFlag = [dict[@"praizeFlag"] intValue];
        self.review = dict[@"review"];
    }
    return self;
}

+ (instancetype)extendInfoWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
