//
//  IWCourse.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWCourse.h"
#import "MJExtension.h"
#import "NSDate+IW.h"

@implementation IWCourse
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (NSString *)insertTime {
    // 20140901151648
    // 1. 获取新闻发送的时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddHHmmss";
    NSDate *createdDate = [fmt dateFromString:_insertTime];
    
    // 2. 判断发送时间和现在时间的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createdDate.deltaWithNow.minute];
        } else {
            return NSLocalizedString(@"just_now", nil);
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm", NSLocalizedString(@"yesterday", nil)];
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createdDate];
    }
}
@end
