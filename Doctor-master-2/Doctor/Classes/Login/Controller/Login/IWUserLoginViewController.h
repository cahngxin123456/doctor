//
//  IWUserLoginViewController.h
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWUser;

@interface IWUserLoginViewController : UIViewController
@property (nonatomic, copy) NSString *cellphone;
@property (nonatomic, strong) IWUser *user;
@end
