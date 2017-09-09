//
//  IWDetailBottom2View.h
//  Conedot
//
//  Created by 范超 on 14/12/19.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWDetailBottom2View;
@class IWDetailExtendInfo;

@protocol IWDetailBottom2ViewDelegate <NSObject>

@optional
- (void)apply2:(UIButton *)button;
- (void)known2:(UIButton *)button;
- (void)signup2:(UIButton *)button;
- (void)comment2:(UIButton *)button;

@end

@interface IWDetailBottom2View : UIView

+ (instancetype)detailBottom2View;

@property (nonatomic, weak) id<IWDetailBottom2ViewDelegate> delegate;

- (void)setStatus:(IWDetailExtendInfo *)extendInfo;

@end
