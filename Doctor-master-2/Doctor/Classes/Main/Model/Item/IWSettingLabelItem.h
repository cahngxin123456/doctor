//
//  IWSettingLabelItem.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingValueItem.h"

@interface IWSettingLabelItem : IWSettingValueItem
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *defaultText;
@end
