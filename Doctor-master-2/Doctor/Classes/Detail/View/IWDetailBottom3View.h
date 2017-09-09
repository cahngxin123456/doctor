//
//  IWDetailBottom3View.h
//  Conedot
//
//  Created by 范超 on 16/4/9.
//  Copyright © 2016年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWDetailExtendInfo;

@protocol IWDetailBottom3ViewDelegate <NSObject>

@optional
- (void)known3:(UIButton *)button;

@end

@interface IWDetailBottom3View : UIView
+ (instancetype)detailBottom3View;

@property (nonatomic, weak) id<IWDetailBottom3ViewDelegate> delegate;

- (void)setStatus:(IWDetailExtendInfo *)extendInfo;
@end
