//
//  IWTrainningTool.m
//  Conedot
//
//  Created by 范超 on 15/1/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTrainningTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWTrainningTool

+ (void)trainningSystemWithParam:(IWTrainningParam *)param success:(void (^)(IWTrainningResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_TRAINNING_SYSTEM_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWTrainningResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWTrainningResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWTrainningResult alloc] init];
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

+ (void)trainningManagerSystemWithParam:(IWTrainningManagerParam *)param success:(void (^)(IWTrainningResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_LEARN_TASK_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWTrainningResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWTrainningResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWTrainningResult alloc] init];
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

+ (void)trainningManagerCourseWithParam:(IWTrainningCourseParam *)param success:(void (^)(IWTrainningCourseResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_TRAIN_CLASS_LIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWTrainningCourseResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWTrainningCourseResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWTrainningCourseResult alloc] init];
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

+ (void)joinRefuseCouseWithParams:(IWJoinRefuseCourseParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error)) failure {
    [IWHttpTool postWithURL:SERVER_JOIN_OR_REFUSE_TRAIN_CLASS_URL params:param.keyValues success:^(id json) {
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
@end
