//
//  IWCompanyUnReadResult.h
//  Conedot
//
//  Created by 范超 on 15/1/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWBaseResult.h"
@class IWUnRead;

@interface IWCompanyUnReadResult : IWBaseResult
/**
 *  分页数据
 */
@property (nonatomic, strong) IWUnRead *datas;
@end
