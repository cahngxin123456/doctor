//
//  IWMyDoctorResult.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWMyDoctorResult.h"
#import "IWMyDoctor.h"

@implementation IWMyDoctorResult
- (NSDictionary *)objectClassInArray {
    return @{@"datas" : [IWMyDoctor class]};
}
@end
