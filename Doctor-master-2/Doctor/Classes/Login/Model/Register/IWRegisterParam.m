//
//  IWRegisterParam.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWRegisterParam.h"
#import "NSString+IW.h"

@implementation IWRegisterParam
- (void)setPwd:(NSString *)pwd {
    _pwd = [NSString md5:pwd];
}

- (NSString *)channel {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [NSString stringWithFormat:@"IOS-%@-V%@", [UIDevice currentDevice].systemVersion, app_build];
}
@end
