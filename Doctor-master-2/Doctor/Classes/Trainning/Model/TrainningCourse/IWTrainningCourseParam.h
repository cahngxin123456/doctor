//
//  IWTrainningCourseParam.h
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWBaseCompanyParam.h"

typedef enum {
    IWTrainningCourseTypeAll = 1,
    IWTrainningCourseTypeMine,
    IWTrainningCourseTypeLast
} IWTrainningCourseType;

@interface IWTrainningCourseParam : IWBaseCompanyParam

@property (nonatomic, assign) IWTrainningCourseType listType;

@end
