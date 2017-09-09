//
//  IWJiBing.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWJiBing.h"
#import "MJExtension.h"

@implementation IWJiBing
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
