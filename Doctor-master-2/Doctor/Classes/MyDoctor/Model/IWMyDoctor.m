//
//  IWMyDoctor.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWMyDoctor.h"
#import "MJExtension.h"

@implementation IWMyDoctor
/**
 *  将返回的JSON中的字段转换成对应的变量
 */
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}
@end
