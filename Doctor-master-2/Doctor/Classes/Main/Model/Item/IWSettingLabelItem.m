//
//  IWSettingLabelItem.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingLabelItem.h"

@implementation IWSettingLabelItem
- (NSString *)text {
    id value = [IWUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.defaultText;
    } else {
        return value;
    }
}

- (void)setText:(NSString *)text {
    [IWUserDefaults setObject:text forKey:self.key];
    [IWUserDefaults synchronize];
}
@end
