//
//  IWApprovalTool.m
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import "IWApprovalTool.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWApprovalTool

+ (void)addApprovalQingJia:(IWAddQingJiaParam *)param datas:(NSArray *)datas success:(void (^)(IWApprovalResult *result))success failure:(void (^)(NSError *error))failure {
    [IWHttpTool updateImageWithURL:@"填实际的地址" params:param.keyValues datas:datas name:@"attachment" success:^(id json) {
        IWLog(@"%@", json);
        if (success) {
            IWApprovalResult *result = [[IWApprovalResult alloc] init];;
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
