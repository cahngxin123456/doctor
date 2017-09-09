//
//  IWCompanyBaseController.h
//  Conedot
//
//  Created by 范超 on 14-10-7.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWFanCompany.h"

@interface IWCompanyBaseController : UITableViewController
/**
 *  公司
 */
@property (nonatomic, strong) IWFanCompany *company;
@end
