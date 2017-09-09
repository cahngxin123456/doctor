//
//  IWCompanyMenuParam.h
//  Conedot
//
//  Created by 范超 on 15/3/9.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCompanyMenuParam : NSObject
/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

/**
 *  功能类型(
 *  学习培训 training 
 *  薪资单 payslip
 *  招聘 recruit
 *  请假 leave
 *  申请中心 application 
 *  审批中心 examine
 *  通知 notice
 *  新闻 news
 *  制度查询 policy 
 *  调查问卷 questionnaire 
 *  意见检验 feedback
 *  )
 */
@property (nonatomic, copy) NSString *functionType;
@end
