//
//  IWHomeBannerResult.m
//  Conedot
//
//  Created by 范超 on 15/5/22.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHomeBannerResult.h"
#import "MJExtension.h"
#import "IWBanner.h"

@implementation IWHomeBannerResult
- (NSDictionary *)objectClassInArray {
    return @{@"datas" : [IWBanner class]};
}
@end
