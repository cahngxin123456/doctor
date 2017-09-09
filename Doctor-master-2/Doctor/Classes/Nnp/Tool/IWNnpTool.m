//
//  IWNnpTool.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWNnpTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWNnpTool

+ (void)nnpWithParam:(IWNppParam *)param success:(void (^)(IWNppResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool postWithURL:SERVER_GET_TRAVOR_GETNNPLIST_URL params:param.keyValues success:^(id json) {
        if (success) {
            IWLog(@"%@", json);
            IWNppResult *result = nil;
            if ([json[@"code"] intValue] == 0) {
                result = [IWNppResult objectWithKeyValues:json[@"datas"]];
            } else {
                result = [[IWNppResult alloc] init];
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
