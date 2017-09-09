//
//  IWAddBaseApprovalParam.h
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAddBaseApprovalParam : NSObject
@property (nonatomic, copy) NSString *loginId; // 登录 ID
@property (nonatomic, copy) NSString *companyId; // 公司 ID
@property (nonatomic, copy) NSString *formName; // 表单名
@property (nonatomic, copy) NSString *approvalUserId; // 审批人 ID
@property (nonatomic, copy) NSString *approvalUserName; // 审批人姓名
@property (nonatomic, copy) NSString *ccUserId; // 抄送人 ID
@property (nonatomic, copy) NSString *ccUserName; // 抄送人姓名
@property (nonatomic, copy) NSString *summary; // 摘要
@end
