//
//  IWAddressResult.m
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAddressResult.h"

@implementation IWAddressResult
- (NSDictionary *)objectClassInArray {
    return @{@"datas" : [IWAddress class]};
}
@end
