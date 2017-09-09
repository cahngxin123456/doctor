//
//  IWTabBarButton.h
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWTabBarButton : UIButton
@property (nonatomic, strong) UITabBarItem *item;
@property (nonatomic, assign) BOOL isButton;
@end
