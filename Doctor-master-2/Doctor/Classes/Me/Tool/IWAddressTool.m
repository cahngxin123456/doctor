//
//  IWAddressTool.m
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWAddressTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWAddressTool

+ (void)addressWithParam:(IWAddressParam *)param success:(void(^)(IWAddressResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_ADDRESS_URL params:param.keyValues success:^(id json) {
        IWLog(@"%@", json);
        IWAddressResult *result = nil;
        if ([json[@"code"] intValue] == 0) {
            result = [IWAddressResult objectWithKeyValues:json];
        } else {
            result = [[IWAddressResult alloc] init];
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
@end
