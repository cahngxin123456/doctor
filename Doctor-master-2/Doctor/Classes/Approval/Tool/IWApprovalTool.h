//
//  IWApprovalTool.h
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWAddQingJiaParam.h"
#import "IWApprovalResult.h"


@interface IWApprovalTool : NSObject


+ (void)addApprovalQingJia:(IWAddQingJiaParam *)param datas:(NSArray *)datas success:(void (^)(IWApprovalResult *result))success failure:(void (^)(NSError *error))failure;


@end
