//
//  IWContactTool.m
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWContactTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

#define IWContactTopTitle @"ContactTopTitle"

@implementation IWContactTool

+ (void)saveTopTitle:(NSString *)title {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *topTitle = [defaults objectForKey:IWContactTopTitle];
    NSString *s = [NSString stringWithFormat:@"%@%@", topTitle == nil ? @"" : @"," , title];
    [defaults setObject:[topTitle stringByAppendingString:s] forKey:IWContactTopTitle];
    [defaults synchronize];
}

+ (NSString *)topTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:IWContactTopTitle];
}

+ (void)removeTopTitle {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:IWContactTopTitle];
    [defaults synchronize];
}

+ (void)contactWithParam:(IWContactParam *)param success:(void(^)(IWContactResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_CONTACT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWContactResult *result = [[IWContactResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            result.datas = json[@"datas"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)commonContactWithParam:(IWContactParam *)param success:(void(^)(IWCommonContactResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_COMMON_CONTACT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWCommonContactResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWCommonContactResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWCommonContactResult alloc] init];
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

+ (void)getCommunityList:(IWGetCommunityParam *)param success:(void(^)(IWGetCommunityResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_COMMUNITY_HOSPITAL_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWGetCommunityResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetCommunityResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWGetCommunityResult alloc] init];
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

+ (void)getHospitalList:(IWGetHosptialParam *)param success:(void(^)(IWGetHospitalContactResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_HOSPITAL_CONTACT_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWGetHospitalContactResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWGetHospitalContactResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWGetHospitalContactResult alloc] init];
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

+ (void)departmentWithParam:(IWContactLevelParam *)param success:(void(^)(IWContactLevelResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_COMMUNITY_HOSPITAL_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWContactLevelResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWContactLevelResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWContactLevelResult alloc] init];
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
