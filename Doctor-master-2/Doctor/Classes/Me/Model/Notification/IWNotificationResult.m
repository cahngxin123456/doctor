//
//  IWNotificationResult.m
//  Conedot
//
//  Created by 范超 on 14/12/16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWNotificationResult.h"
#import "IWNotification.h"

@implementation IWNotificationResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWNotification class]};
}
@end
