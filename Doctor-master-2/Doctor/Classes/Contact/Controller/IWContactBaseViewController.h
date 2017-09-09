//
//  IWContactBaseViewController.h
//  Conedot
//
//  Created by 范超 on 15/4/16.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWContactBaseViewController : UITableViewController
@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, copy) NSString *nTitle;
@property (nonatomic, assign) BOOL isApproval;
@end
