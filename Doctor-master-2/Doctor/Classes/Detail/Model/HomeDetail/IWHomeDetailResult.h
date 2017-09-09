//
//  IWHomeDetailResult.h
//  Conedot
//
//  Created by 范超 on 14-9-27.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWBaseResult.h"

@interface IWHomeDetailResult : IWBaseResult
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  内容
 */
@property (nonatomic, copy) NSString *content;
@end
