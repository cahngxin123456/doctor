//
//  IWPicAndTextMessageDiagnoseHeaderView.h
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import <UIKit/UIKit.h>
#import "IWPicAndTextMessageDiagnoseSelectPickedView.h"

@interface IWPicAndTextMessageDiagnoseHeaderView : UIView

@property (nonatomic, weak) UIImageView *wrapImgView;
@property (nonatomic, weak) UIButton *buttonOne;
@property (nonatomic, weak) UIButton *buttonTwo;
@property (nonatomic, weak) UIButton *buttonThree;
@property (nonatomic, weak) UILabel *bottomLabel;
//@property (nonatomic, weak) IWPicAndTextMessageDiagnoseSelectPickedView *pickedView;

@property (nonatomic ,copy) void(^buttonTapBlock)(NSInteger );

+ (instancetype)IWPicAndTextMessageDiagnoseHeaderViewWithFrame:(CGRect)frame;


@end
