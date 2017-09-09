//
//  IWAddressResult.h
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBaseResult.h"
#import "IWAddress.h"

@interface IWAddressResult : IWBaseResult
/**
 *  分页数据
 */
@property (nonatomic, strong) NSArray *datas;
@end
