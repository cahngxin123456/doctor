//
//  IWSettingItem.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingItem.h"

@implementation IWSettingItem
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title {
    IWSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithIcon:nil title:title];
}

+ (instancetype)item {
    return [[self alloc] init];
}
@end
