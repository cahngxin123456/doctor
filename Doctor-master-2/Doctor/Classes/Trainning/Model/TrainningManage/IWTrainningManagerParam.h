//
//  IWTrainningManagerParam.h
//  Conedot
//
//  Created by 范超 on 16/4/9.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWBaseCompanyParam.h"

typedef enum {
    IWTrainningManagerTypeLearnTask = 1,
    IWTrainningManagerTypeTrainningCourses,
} IWTrainningManagerType;

@interface IWTrainningManagerParam : IWBaseCompanyParam
/**
 *  手册类型(1 自学任务 2 培训课程)
 */
@property (nonatomic, assign) IWTrainningManagerType manualType;

/**
 *  查询条件(标题)
 */
@property (nonatomic, copy) NSString *condition;
@end
