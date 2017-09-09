//
//  IWRemind.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWRemind.h"
#import "MJExtension.h"

@implementation IWRemind
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"rnewReply" : @"newReply"};
}
@end
