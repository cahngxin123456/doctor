//
//  IWHelpDetailResult.h
//  Conedot
//
//  Created by 范超 on 15/4/5.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWBaseResult.h"

@interface IWHelpDetailResult : IWBaseResult

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
