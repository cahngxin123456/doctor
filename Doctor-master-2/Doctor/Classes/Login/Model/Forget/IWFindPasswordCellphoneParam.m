//
//  IWFindPasswordCellphoneParam.m
//  Conedot
//
//  Created by 范超 on 14-10-9.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWFindPasswordCellphoneParam.h"
#import "NSString+IW.h"

@implementation IWFindPasswordCellphoneParam

- (void)setPwdNew:(NSString *)pwdNew {
    _pwdNew = [NSString md5:pwdNew];
}

- (void)setSecurityCode:(NSString *)securityCode {
    _securityCode = [NSString md5:securityCode];
}
@end
