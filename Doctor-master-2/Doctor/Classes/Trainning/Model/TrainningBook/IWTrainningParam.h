//
//  IWTrainningParam.h
//  Conedot
//
//  Created by 范超 on 15/1/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWBaseCompanyParam.h"

typedef enum {
    IWTrainningBookTypeSystem = 1,
    IWTrainningBookTypeIntro,
    IWTrainningBookTypeTeacher,
    IWTrainningBookTypeSpecial,
    IWTrainningBookTypeOption
} IWTrainningBookType;

@interface IWTrainningParam : IWBaseCompanyParam
/**
 *  手册类型(1 培训体系 2 课程介绍 3 讲师介 绍 4 特别项目 5 常见 问题)
 */
@property (nonatomic, assign) IWTrainningBookType manualType;

/**
 *  查询条件(标题)
 */
@property (nonatomic, copy) NSString *condition;
@end
