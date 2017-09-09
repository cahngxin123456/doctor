//
//  IWSettingViewController.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWSettingGroup;

@interface IWSettingViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *groups;

- (IWSettingGroup *)addGroup;
@end
