//
//  IWTrainningCourseViewController.h
//  Conedot
//
//  Created by 范超 on 16/7/2.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWCompanyBaseController.h"
#import "IWTrainningCourseParam.h"
#import "MJRefresh.h"

@interface IWTrainningCourseViewController : IWCompanyBaseController

@property (nonatomic, weak) MJRefreshHeaderView *header;

@property (nonatomic, assign) IWTrainningCourseType listType;
@property (nonatomic, strong) UINavigationController *nav;
@end
