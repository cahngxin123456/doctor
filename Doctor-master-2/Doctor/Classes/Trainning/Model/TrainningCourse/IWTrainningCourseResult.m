//
//  IWTrainningCourseResult.m
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWTrainningCourseResult.h"
#import "MJExtension.h"
#import "IWCourse.h"

@implementation IWTrainningCourseResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWCourse class]};
}
@end
