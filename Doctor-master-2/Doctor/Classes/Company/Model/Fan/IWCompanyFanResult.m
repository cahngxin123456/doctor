//
//  IWCompanyFanResult.m
//  Conedot
//
//  Created by 范超 on 14-9-28.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWCompanyFanResult.h"
#import "IWFanCompany.h"

@implementation IWCompanyFanResult
- (NSDictionary *)objectClassInArray {
    return @{@"datas" : [IWFanCompany class]};
}
@end
