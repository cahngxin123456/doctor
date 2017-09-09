//
//  IWBaseMedicalParam.m
//  Doctor
//
//  Created by 范超 on 2016/12/26.
//
//

#import "IWBaseMedicalParam.h"

@implementation IWBaseMedicalParam

- (instancetype)init {
    self.loginId = [IWUserTool user].loginId;
    self.companyId = @(IWCompanyId);
    return [super init];
}

@end
