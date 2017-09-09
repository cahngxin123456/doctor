//
//  IWHelpResult.m
//  Conedot
//
//  Created by 范超 on 15/3/31.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWHelpResult.h"
#import "MJExtension.h"
#import "IWHelp.h"

@implementation IWHelpResult
- (NSDictionary *)objectClassInArray {
    return @{@"pageData" : [IWHelp class]};
}
@end
