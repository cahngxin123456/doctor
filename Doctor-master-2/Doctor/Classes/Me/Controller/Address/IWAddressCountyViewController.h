//
//  IWAddressCountyViewController.h
//  Conedot
//
//  Created by 范超 on 14-10-21.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWAddress.h"

@interface IWAddressCountyViewController : UITableViewController
@property (nonatomic, strong) IWAddress *address;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) BOOL isSocial;
@end
