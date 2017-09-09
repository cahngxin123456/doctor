//
//  IWCommonTool.m
//  Conedot
//
//  Created by 范超 on 15/4/3.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWCommonTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWCommonTool
+ (void)getVersionWithParam:(IWGetVersionParam *)param success:(void(^)(IWGetVersionResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_VERSION params:param.keyValues success:^(id json) {
        IWLog(@"json: %@", json);
        IWGetVersionResult *result = nil;
        if ([json[@"code"] intValue] == 0 && !([json[@"datas"] isEqualToString:@""])) {
            result = [IWGetVersionResult objectWithKeyValues:json];
        } else {
            result = [[IWGetVersionResult alloc] init];
            result.code = [json[@"code"] intValue];
            result.info = json[@"info"];
        }
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)readAllNewsWithParam:(IWReadAllNewsParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure {
//    [IWHttpTool postWithURL:SERVER_NEWS_KEY_READ_URL params:param.keyValues success:^(id json) {
//        if (success) {
//            IWLog(@"%@", json);
//            IWBaseResult *result = nil;
//            if ([json[@"code"] intValue] == 0) {
//                result = [IWBaseResult objectWithKeyValues:json];
//            } else {
//                result = [[IWBaseResult alloc] init];
//                result.code = [json[@"code"] intValue];
//                result.info = json[@"info"];
//            }
//            success(result);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

@end
