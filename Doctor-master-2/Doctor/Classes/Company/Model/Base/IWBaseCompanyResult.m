//
//  IWBaseCompanyResult.m
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBaseCompanyResult.h"
#import "MJExtension.h"
#import "IWNews.h"

@implementation IWBaseCompanyResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWNews class]};
}
@end
