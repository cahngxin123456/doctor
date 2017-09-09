//
//  IWSettingValueItem.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingValueItem.h"

@implementation IWSettingValueItem
- (NSString *)key {
    return _key ? _key : self.title;
}
@end
