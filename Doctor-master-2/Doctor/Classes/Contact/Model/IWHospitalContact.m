//
//  IWHospitalContact.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWHospitalContact.h"
#import "MJExtension.h"

@implementation IWHospitalContact
- (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"desc" : @"description"};
}
@end
