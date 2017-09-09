//
//  IWUserInfoViewController.h
//  Conedot
//
//  Created by 范超 on 14-10-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWPeople;

@interface IWUserInfoViewController : UIViewController
/**
 *  公司 ID
 */
@property (nonatomic, assign) long companyId;

/**
 *  人员
 */
@property (nonatomic, strong) IWPeople *people;
@end
