//
//  IWMeHeaderView.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWUser, IWMeHeaderView;

@protocol IWMeHeaderViewDelegate <NSObject>
@optional
- (void)iconChange:(UIImageView *)imageView;
- (void)viewClick;
@end

@interface IWMeHeaderView : UIView

@property (nonatomic, strong) IWUser *user;

+ (instancetype)headerView;

@property (nonatomic, weak) id<IWMeHeaderViewDelegate> delegate;
@end
