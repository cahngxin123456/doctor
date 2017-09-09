//
//  IWScrollHeaderView.h
//  Conedot
//
//  Created by 范超 on 15/6/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWBanner;

@protocol IWScrollHeaderViewDelegate <NSObject>

@optional
- (void)headerViewTapWithBanner:(IWBanner *)banner;

@end

@interface IWScrollHeaderView : UIView

+ (instancetype)headerView;

// 图片集合
@property (nonatomic, strong) NSArray *newses;

@property (nonatomic, weak) id<IWScrollHeaderViewDelegate> delegate;

- (void)addTimer;
- (void)removeTimer;
@end
