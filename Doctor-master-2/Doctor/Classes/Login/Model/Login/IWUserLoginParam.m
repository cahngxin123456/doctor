//
//  IWUserLoginParam.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWUserLoginParam.h"
#import "NSString+IW.h"

@implementation IWUserLoginParam

- (void)setPwd:(NSString *)pwd {
    _pwd = [NSString md5:pwd];
}

@end
