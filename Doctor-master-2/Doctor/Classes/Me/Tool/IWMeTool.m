//
//  IWMeTool.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWMeTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"
#import "AFNetworking.h"

@implementation IWMeTool


+ (void)updateIconWithParams:(IWMeParam *)param data:(NSData *)data success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure{
    NSMutableArray *datas = [NSMutableArray array];
    [datas addObject:data];
    [IWHttpTool updateImageWithURL:SERVER_CHANGE_USER_URL params:param.keyValues datas:datas name:@"photo" success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)changeUserInfoWithParam:(IWMeParam *)param success:(void (^)(IWBaseResult *))success failure:(void (^)(NSError *))failure {
    [IWHttpTool postWithURL:SERVER_CHANGE_USER_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)changePasswordInfoWithParam:(IWChangePasswordParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_CHANGE_PASSWORD_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)changeStatusCompanyWithParam:(IWStatusCompanyParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_CHANGE_FANS_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)changeCellPhoneWithParam:(IWChangeCellPhoneParam *)param success:(void(^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_CHANGE_CELLPHONE_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)notificationWithParam:(IWNotificationParam *)param success:(void (^)(IWNotificationResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_ME_NOTIFICATION_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"json: %@", json);
            IWNotificationResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWNotificationResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWNotificationResult alloc] init];
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

+ (void)notificationKnownWithParam:(IWNotificationKnownParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_ME_NOTIFICATION_KNOWN_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWBaseResult *result = [[IWBaseResult alloc] init];;
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

+ (void)helpWithParam:(IWHelpParam *)param success:(void (^)(IWHelpResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_TRAVOR_FEEDBACK_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"json: %@", json);
            IWHelpResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWHelpResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWHelpResult alloc] init];
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

+ (void)helpDetailWithParam:(IWHelpDetailParam *)param success:(void (^)(IWHelpDetailResult *))success failure:(void (^)(NSError *))failure {
    [IWHttpTool postWithURL:SERVER_GET_TRAVOR_FEEDBACK_DETAIL_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"json: %@", json);
            IWHelpDetailResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWHelpDetailResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWHelpDetailResult alloc] init];
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


+ (void)userFeedbackSubmitWithParam:(IWUserFeedbackParam *)param success:(void (^)(IWUserFeedbackResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_SUBMIT_TRAVOR_FEEDBACK_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWUserFeedbackResult *result = [[IWUserFeedbackResult alloc] init];;
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

+ (void)userFeedbackSubmitWithParam:(IWUserFeedbackParam *)param path:(NSString *)path success:(void (^)(IWUserFeedbackResult *result))success failure:(void (^)(NSError *error))failure {
    
    [IWHttpTool updateImageWithUrl:SERVER_SUBMIT_TRAVOR_FEEDBACK_URL params:param.keyValues path:path success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWUserFeedbackResult *result = [[IWUserFeedbackResult alloc] init];;
            result.code = [json[@"code"] longValue];
            result.info = json[@"info"];
            success(result);
        }
        
    } failure:^(NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
