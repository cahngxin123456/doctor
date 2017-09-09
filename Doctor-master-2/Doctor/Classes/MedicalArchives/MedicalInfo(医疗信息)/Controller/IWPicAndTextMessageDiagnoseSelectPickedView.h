//
//  IWPicAndTextMessageDiagnoseSelectPickedView.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>

@interface IWPicAndTextMessageDiagnoseSelectPickedView : UIView

@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, weak) UIView *bottomLineView;

@property (nonatomic ,copy) NSString *titleOne;
@property (nonatomic ,copy) NSString *titleTwo;

@property (nonatomic ,copy) void(^buttonTapBlock)(NSInteger );

+ (instancetype)IWPicAndTextMessageDiagnoseSelectPickedViewWithFrame:(CGRect)frame;

@end
