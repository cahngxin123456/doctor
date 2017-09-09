//
//  IWAddBaseApprovalParam.m
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import "IWAddBaseApprovalParam.h"

@implementation IWAddBaseApprovalParam

- (instancetype)init {
    _loginId = [IWUserTool user].loginId;
    return self;
}

@end
