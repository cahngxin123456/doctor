//
//  IWNewsParam.h
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWBaseCompanyParam.h"

@interface IWNewsParam : IWBaseCompanyParam
/**
 *  查询条件
 */
@property (nonatomic, copy) NSString *condition;
@end
