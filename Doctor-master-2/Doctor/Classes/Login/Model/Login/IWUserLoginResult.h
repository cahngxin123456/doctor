//
//  IWUserLoginResult.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWBaseResult.h"
@class IWUser;

@interface IWUserLoginResult : IWBaseResult
/**
 *  成功后的数据
 */
@property (nonatomic, strong) IWUser *datas;

@end
