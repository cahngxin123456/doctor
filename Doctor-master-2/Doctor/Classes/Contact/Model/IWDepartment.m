//
//  IWDepartment.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWDepartment.h"
#import "MJExtension.h"

@implementation IWDepartment
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"deptId" : @"communityId", @"deptName" : @"communityName", @"deptParentId" : @"communityParentId", @"deptRemarkName" : @"communityRemarkName"};
}
@end
