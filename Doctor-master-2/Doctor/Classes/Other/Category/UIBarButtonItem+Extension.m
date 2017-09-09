//
//  UIBarButtonItem+Extension.m
//  Conedot
//
//  Created by 范超 on 15/4/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension) 
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
