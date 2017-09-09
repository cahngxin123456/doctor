//
//  IWChangePasswordParam.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWChangePasswordParam.h"
#import "NSString+IW.h"

@implementation IWChangePasswordParam
- (void)setPwdNew:(NSString *)pwdNew {
    _pwdNew = [NSString md5:pwdNew];
}
@end
