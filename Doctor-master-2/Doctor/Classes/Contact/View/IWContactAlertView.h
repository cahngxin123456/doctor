//
//  IWContactAlertView.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IWContactAlertView, IWPeople;

@protocol IWContactAlertViewDelegate <NSObject>

@optional
- (void)dialPhone:(IWContactAlertView *)alertView;
- (void)sendMail:(IWContactAlertView *)alertView;
- (void)peopleInfo:(IWContactAlertView *)alertView;

@end

@interface IWContactAlertView : UIView

@property (nonatomic, strong) id<IWContactAlertViewDelegate> delegate;
- (instancetype)initWithPeople:(IWPeople *)people;

- (void)show;

- (void)dismiss;
@end
