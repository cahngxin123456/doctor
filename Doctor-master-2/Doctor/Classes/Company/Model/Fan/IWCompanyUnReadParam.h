//
//  IWCompanyUnReadParam.h
//  Conedot
//
//  Created by 范超 on 15/1/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWCompanyUnReadParam : NSObject

/**
 *  登录 ID
 */
@property (nonatomic, copy) NSString *loginId;

/**
 *  公司 ID
 */
@property (nonatomic, strong) NSNumber *companyId;

@property (nonatomic, copy) NSString *type;

@end
