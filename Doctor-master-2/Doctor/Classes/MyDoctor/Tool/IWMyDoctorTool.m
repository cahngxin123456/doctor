//
//  IWMyDoctorTool.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWMyDoctorTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWMyDoctorTool
+ (void)myDoctorWithParam:(IWMyDoctorParam *)param success:(void (^)(IWMyDoctorResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_MY_DOCTORLIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWMyDoctorResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWMyDoctorResult objectWithKeyValues:json];
            } else {
                result = [[IWMyDoctorResult alloc] init];
                result.code = [json[@"code"] intValue];
                result.info = json[@"info"];
            }
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
