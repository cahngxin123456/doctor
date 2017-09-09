//
//  IWCommonContactResult.m
//  Conedot
//
//  Created by 范超 on 16/4/3.
//  Copyright © 2016年 范超. All rights reserved.
//

#import "IWCommonContactResult.h"
#import "IWCommonContact.h"

@implementation IWCommonContactResult
- (NSDictionary *)objectClassInArray {
    return @{@"contactDatas" : [IWCommonContact class]};
}
@end
