//
//  IWRegisterOneParam.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWRegisterOneParam.h"
#import "NSString+IW.h"

@implementation IWRegisterOneParam
- (void)setSecurityCode:(NSString *)securityCode {
    _securityCode = [NSString md5:securityCode];
}
@end
