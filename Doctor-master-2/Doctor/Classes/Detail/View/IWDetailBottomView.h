//
//  IWDetailBottomView.h
//  Conedot
//
//  Created by 范超 on 14/12/13.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWDetailBottomView;
@class IWDetailExtendInfo;

@protocol IWDetailBottomViewDelegate <NSObject>

@optional
- (void)known:(UIButton *)button;
- (void)signup:(UIButton *)button;
- (void)comment:(UIButton *)button;

@end

@interface IWDetailBottomView : UIView

+ (instancetype)detailBottomView;

@property (nonatomic, weak) id<IWDetailBottomViewDelegate> delegate;

- (void)setStatus:(IWDetailExtendInfo *)extendInfo;

@end
