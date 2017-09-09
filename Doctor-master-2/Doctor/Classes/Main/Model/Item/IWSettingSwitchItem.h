//
//  IWSettingSwitchItem.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingValueItem.h"

@interface IWSettingSwitchItem : IWSettingValueItem
@property (nonatomic, assign, getter = isOn) BOOL on;
@property (assign, nonatomic, getter = isDefaultOn) BOOL defaultOn;
@end
