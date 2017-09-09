//
//  IWUserTool.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWUserTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"
#import "IWUser.h"

#define IWUserFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]
#define IWUserDefault [NSUserDefaults standardUserDefaults]

@implementation IWUserTool

+ (void)userLoginWithParam:(IWUserLoginParam *)param success:(void (^)(IWUserLoginResult *))success failure:(void (^)(NSError *))failure {
    [IWHttpTool postWithURL:SERVER_LOGIN_URL params:param.keyValues success:^(id json) {
        IWLog(@"login---%@", json);
        if (success) {
            IWUserLoginResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWUserLoginResult objectWithKeyValues:json];
            } else {
                result = [[IWUserLoginResult alloc] init];
                result.code = [json[@"code"] longValue];
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

+ (void)saveUser:(IWUser *)user {
    [NSKeyedArchiver archiveRootObject:user toFile:IWUserFile];
}

+ (void)removeUser {
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:IWUserFile error:nil];
}

+ (IWUser *)user {
    // 取出账号
    IWUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:IWUserFile];
    
    return user;
}

+ (void)saveAccessToken:(NSString *)accessToken {
    [IWUserDefault setObject:accessToken forKey:@"accessToken"];
}

+ (NSString *)accessToken {
    return [IWUserDefault objectForKey:@"accessToken"] == nil ? @"test" : [IWUserDefault objectForKey:@"accessToken"];
}

+ (void)userRegisterScWithParam:(IWRegisterScParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_REGISTER_SC_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWRegisterScResult *result = [[IWRegisterScResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userChangePhoneScWithParam:(IWResetCellphoneParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_RESET_PASSWORD_SC_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWRegisterScResult *result = [[IWRegisterScResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userRegisterOneWithParam:(IWRegisterOneParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_DO_CHECK_REGSITER_SC_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWBaseResult objectWithKeyValues:json];
            } else {
                result = [[IWBaseResult alloc] init];
                result.code = [json[@"code"] longValue];
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

+ (void)userRegisterWithParam:(IWRegisterParam *)param success:(void(^)(IWRegisterResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_REGISTER_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWRegisterResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWRegisterResult objectWithKeyValues:json];
            } else {
                result = [[IWRegisterResult alloc] init];
                result.code = [json[@"code"] longValue];
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

+ (void)userPasswordScWithParam:(IWRegisterScParam *)param success:(void(^)(IWRegisterScResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_PASSWORD_SC_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWRegisterScResult *result = [[IWRegisterScResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userFindPasswordCellphoneWithParam:(IWFindPasswordCellphoneParam *)param success:(void(^)(IWFindPasswordResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_FIND_PASSWORD_CELLPHONE_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWFindPasswordResult *result = [[IWFindPasswordResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userFindPasswordEmailWithParam:(IWFindPasswordEmailParam *)param success:(void(^)(IWFindPasswordResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_FIND_PASSWORD_EMAIL_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWFindPasswordResult *result = [[IWFindPasswordResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithParam:(IWUserInfoParam *)param success:(void(^)(IWUserInfoResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_PERSON_INFO_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWUserInfoResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWUserInfoResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWUserInfoResult alloc] init];
                result.code = [json[@"code"] longValue];
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
