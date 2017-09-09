//
//  IWApprovalResult.h
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import "IWBaseResult.h"
@class IWApprovalId;

@interface IWApprovalResult : IWBaseResult
// {"code":0,"datas":{"id":"297e9e794fcbfb4a014fcef7ee300345"},"info":"请求成功"}
@property (nonatomic, strong) IWApprovalId *datas;
@end
