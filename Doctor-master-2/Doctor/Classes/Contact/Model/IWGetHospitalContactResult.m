//
//  IWGetHospitalContactResult.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWGetHospitalContactResult.h"
#import "IWHospitalContact.h"

@implementation IWGetHospitalContactResult
- (NSDictionary *)objectClassInArray {
    return @{@"contactDatas" : [IWHospitalContact class]};
}
@end
