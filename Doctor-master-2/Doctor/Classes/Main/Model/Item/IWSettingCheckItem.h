//
//  IWSettingCheckItem.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingItem.h"

@interface IWSettingCheckItem : IWSettingItem
@property (assign, nonatomic, getter = isChecked) BOOL checked;
@end
