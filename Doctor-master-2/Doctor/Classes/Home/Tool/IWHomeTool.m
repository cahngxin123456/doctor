//
//  IWHomeTool.m
//  Conedot
//
//  Created by 范超 on 15/5/22.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHomeTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWHomeTool

+ (void)homeBannerWithParam:(IWHomeBannerParam *)param success:(void (^)(IWHomeBannerResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_HOME_DISPLAY params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWHomeBannerResult *result = nil;
            if ([json[@"code"] intValue] == 0 || ![json[@"datas"] isEqualToString:@""]) {
                result = [IWHomeBannerResult objectWithKeyValues:json];
            } else {
                result = [[IWHomeBannerResult alloc] init];
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

+ (void)remindNumberWithParam:(IWRemindParam *)param success:(void (^)(IWRemindResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_REMIND_NUMBER_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWRemindResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWRemindResult objectWithKeyValues:json];
            } else {
                result = [[IWRemindResult alloc] init];
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
