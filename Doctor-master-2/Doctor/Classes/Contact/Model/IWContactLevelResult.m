//
//  IWContactLevelResult.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactLevelResult.h"
#import "IWDepartment.h"
#import "IWPeople.h"

@implementation IWContactLevelResult

- (NSDictionary *)objectClassInArray {
    return @{@"deptDatas" : [IWDepartment class], @"userDatas" : [IWPeople class]};
}
@end
