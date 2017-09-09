//
//  IWRelateCompanyResult.m
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWRelateCompanyResult.h"
#import "IWCompany.h"

@implementation IWRelateCompanyResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWCompany class]};
}
@end
