//
//  IWTabBar.m
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"

@interface IWTabBar()
@property (nonatomic, weak) IWTabBarButton *selectedButton;

@property (nonatomic, weak) IWTabBarButton *homeButton;
@end

@implementation IWTabBar

/** 首页按钮 */
- (UIButton *)homeButton
{
    if (!_homeButton) {
        IWTabBarButton *homeButton = [IWTabBarButton buttonWithType:UIButtonTypeCustom];
        UITabBarItem *item = [[UITabBarItem alloc] init];
        item.title = NSLocalizedString(@"home", nil);
        item.image = [UIImage imageNamed:@"tabbar_home"];
        item.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
        homeButton.isButton = YES;
        homeButton.item = item;
        
        homeButton.tag = 1;
        
        // 3.监听按钮点击
        [homeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:homeButton];
        _homeButton = homeButton;
    }
    return _homeButton;
}

- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item {
    [self addTabBarButtonWithItem:item titleColor:nil];
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item titleColor:(UIColor *)color {
    // 1.创建按钮
    IWTabBarButton *button = [[IWTabBarButton alloc] init];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateSelected];
    }
    
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (color == nil) {
        if (self.tabBarButtons.count == 2) {
            button.tag = 1;
            [self.homeButton setSelected:YES];
            [self buttonClick:button];
        }
    } else {
        if (self.tabBarButtons.count == 1) {
            [self buttonClick:button];
        }
        self.homeButton.hidden = YES;
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(IWTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        if (button.tag != 1) {
            [self.homeButton setSelected:NO];
        }
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / (self.tabBarButtons.count);
    CGFloat buttonY = 0;
    
    for (int index = 0; index < self.tabBarButtons.count; index++) {
        // 1.取出按钮
        IWTabBarButton *button = self.tabBarButtons[index];
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
       button.tag = index;
       
    }
    
    /**** 设置中间的发布按钮的frame ****/
    self.homeButton.width = buttonW;
    self.homeButton.height = buttonH;
    self.homeButton.centerX = self.width * 0.5;
    self.homeButton.centerY = self.height * 0.2;
}

@end
