//
//  IWPopMenu.h
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IWPopMenu;

typedef enum {
    IWPopMenuArrowPositionCenter = 0,
    IWPopMenuArrowPositionLeft = 1,
    IWPopMenuArrowPositionRight = 2
} IWPopMenuArrowPosition;

@protocol IWPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(IWPopMenu *)popMenu;
@end

@interface IWPopMenu : UIView
@property (nonatomic, weak) id<IWPopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) IWPopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
