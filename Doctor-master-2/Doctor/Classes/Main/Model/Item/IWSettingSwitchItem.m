//
//  IWSettingSwitchItem.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingSwitchItem.h"

@implementation IWSettingSwitchItem
- (id)init {
    if (self = [super init]) {
        self.defaultOn = YES;
    }
    return self;
}

- (BOOL)isOn {
    id value = [IWUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.isDefaultOn;
    } else {
        return [value boolValue];
    }
}

- (void)setOn:(BOOL)on {
    [IWUserDefaults setBool:on forKey:self.key];
    [IWUserDefaults synchronize];
}
@end
