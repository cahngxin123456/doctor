//
//  IWTabBar.h
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWTabBar;

@protocol IWTabBarDelegate <NSObject>

@optional
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end

@interface IWTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
- (void)addTabBarButtonWithItem:(UITabBarItem *)item titleColor:(UIColor *)color;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) id<IWTabBarDelegate> delegate;
@end
