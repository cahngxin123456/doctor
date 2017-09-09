//
//  IWGetVersionResult.h
//  Conedot
//
//  Created by 范超 on 15/4/3.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWBaseResult.h"
@class IWUpdate;

@interface IWGetVersionResult : IWBaseResult
/**
 *  数据
 */
@property (nonatomic, strong) IWUpdate *datas;
@end
