//
//  IWPicAndTextMessageDiagnoseHeaderView.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWPicAndTextMessageDiagnoseHeaderView.h"


@implementation IWPicAndTextMessageDiagnoseHeaderView
+ (instancetype)IWPicAndTextMessageDiagnoseHeaderViewWithFrame:(CGRect)frame{
    IWPicAndTextMessageDiagnoseHeaderView *view = [[IWPicAndTextMessageDiagnoseHeaderView  alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    [view wrapImgView];
    [view buttonOne];
    [view buttonTwo];
    [view buttonThree];
    [view bottomLabel];
//    [view pickedView];
    
    return view;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    CGFloat buttonHeight = 60;
    
    [_wrapImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(@(120));
    }];
    [_buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wrapImgView.mas_left).offset(30);
        make.centerY.mas_equalTo(_wrapImgView.mas_centerY);
        make.width.mas_equalTo(@(buttonHeight));
        make.height.mas_equalTo(@(buttonHeight));
    }];
    [_buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_wrapImgView.mas_centerX);
        make.centerY.mas_equalTo(_wrapImgView.mas_centerY);
        make.width.mas_equalTo(@(buttonHeight));
        make.height.mas_equalTo(@(buttonHeight));
    }];
    [_buttonThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_wrapImgView.mas_right).offset(-30);
        make.centerY.mas_equalTo(_wrapImgView.mas_centerY);
        make.width.mas_equalTo(@(buttonHeight));
        make.height.mas_equalTo(@(buttonHeight));
    }];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(_wrapImgView.mas_bottom);
        make.height.mas_equalTo(@(30));
    }];
//    [_pickedView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.top.equalTo(_bottomLabel.mas_bottom);
//        make.height.mas_equalTo(@(50));
//    }];
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UIImageView *)wrapImgView{
    if (_wrapImgView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [imageView setImage:[UIImage resizedImageWithName:@"liuyan_bg"]];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:imageView];
        _wrapImgView = imageView;
    }
    return _wrapImgView;
}

-(UIButton *)buttonOne{
    if (_buttonOne == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(213,140,188)] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(227,180,212)] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = IWFont;
        button.layer.cornerRadius = 30;
        button.clipsToBounds = YES;
        [button setTitle:@"我的" forState:UIControlStateNormal];
        button.tag=0;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_wrapImgView addSubview:button];
        _buttonOne=button;
    }
    return _buttonOne;
}
-(UIButton *)buttonTwo{
    if (_buttonTwo == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(145,188,232)] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(181,210,240)] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = IWFont;
        button.layer.cornerRadius = 30;
        button.clipsToBounds = YES;
        
        [button setTitle:@"家人的" forState:UIControlStateNormal];
        button.tag=1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_wrapImgView addSubview:button];
        _buttonTwo=button;
    }
    return _buttonTwo;
}
-(UIButton *)buttonThree{
    if (_buttonThree == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(228,194,144)] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:IWColor(237,216,182)] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font =IWFont;
        button.layer.cornerRadius = 30;
        button.clipsToBounds = YES;
        
        [button setTitle:@"其他人的" forState:UIControlStateNormal];
        button.tag=2;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_wrapImgView addSubview:button];
        _buttonThree=button;
    }
    return _buttonThree;
}
-(UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.text = @"留言列表";
        label.font = IWFont;
        [self addSubview:label];
        _bottomLabel = label;
    }
    return _bottomLabel;
}
//-(IWPicAndTextMessageDiagnoseSelectPickedView *)pickedView{
//    if (_pickedView == nil) {
//        
//        IWPicAndTextMessageDiagnoseSelectPickedView *pickedView = [IWPicAndTextMessageDiagnoseSelectPickedView IWPicAndTextMessageDiagnoseSelectPickedViewWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)];
//        
//        
//        pickedView.titleOne = @"已提交";
//        pickedView.titleTwo = @"已回复";
//        [self addSubview:pickedView];
//        _pickedView = pickedView;
//    }
//    return _pickedView;
//}

#pragma mark - 事件处理
-(void)buttonClicked:(UIButton *)button{
    if (_buttonTapBlock) {
        _buttonTapBlock(button.tag);
    }
}

#pragma mark - 数据处理

@end
