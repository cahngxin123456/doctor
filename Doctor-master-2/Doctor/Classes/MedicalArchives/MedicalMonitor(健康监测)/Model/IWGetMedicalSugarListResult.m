//
//  IWGetMedicalSugarListResult.m
//  Doctor
//
//  Created by 范超 on 2017/1/7.
//
//

#import "IWGetMedicalSugarListResult.h"
#import "MJExtension.h"
#import "IWBloodSugerModel.h"

@implementation IWGetMedicalSugarListResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWBloodSugerModel class]};
}
@end
