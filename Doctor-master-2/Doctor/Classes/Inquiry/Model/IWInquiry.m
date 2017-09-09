//
//  IWInquiry.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWInquiry.h"
#import "MJExtension.h"
#import "NSDate+IW.h"

@implementation IWInquiry
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setPicture:(NSString *)picture {
    _picture = picture;
    
    _pictures = [_picture componentsSeparatedByString:@","];
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
        fmt.dateFormat = @"MM-dd";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createdDate];
    }
}

@end
