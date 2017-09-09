//
//  IWRegisterResult.h
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBaseResult.h"
@class IWUser;

@interface IWRegisterResult : IWBaseResult
/**
 *  成功后的数据
 */
@property (nonatomic, strong) IWUser *datas;
@end
