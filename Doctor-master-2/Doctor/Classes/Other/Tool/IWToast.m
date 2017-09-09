//
//  IWToast.m
//  Conedot
//
//  Created by 范超 on 14-9-26.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWToast.h"
#import "Toast+UIView.h"

@implementation IWToast

+ (void)toastWithView:(UIView *)view title:(NSString *)title {
    [view makeToast:title duration:1.0f position:@"center"];
}
@end
