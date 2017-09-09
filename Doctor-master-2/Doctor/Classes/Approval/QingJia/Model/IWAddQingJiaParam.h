//
//  IWAddQingJiaParam.h
//  Conedot
//
//  Created by 范超 on 15/10/13.
//  Copyright © 2015年 范超. All rights reserved.
//

#import "IWAddBaseApprovalParam.h"

@interface IWAddQingJiaParam : IWAddBaseApprovalParam
@property (nonatomic, copy) NSString *leaveType; // 请假类型
@property (nonatomic, copy) NSString *leaveFormId; // 请假单 ID(新增请假值 为空 修改请假有值)
@property (nonatomic, copy) NSString *startTime; // 开始时间
@property (nonatomic, copy) NSString *endTime; // 结束时间
@property (nonatomic, copy) NSString *timeSumDay; // 时间总和(天)
@property (nonatomic, copy) NSString *timeSumDayHour; // 时间总和(小时)
@property (nonatomic, copy) NSString *reasons; // 请假理由

@end
