//
//  IWChangeCellPhoneParam.m
//  Conedot
//
//  Created by 范超 on 14-10-16.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWChangeCellPhoneParam.h"
#import "NSString+IW.h"

@implementation IWChangeCellPhoneParam

- (void)setSecurityCode:(NSString *)securityCode {
    _securityCode = [NSString md5:securityCode];
}

@end
