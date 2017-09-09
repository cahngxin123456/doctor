//
//  IWPicAndTextMessageDiagnoseSelectPickedView.m
//  Doctor
//
//  Created by 深水区 on 16/12/27.
//
//

#import "IWPicAndTextMessageDiagnoseSelectPickedView.h"

@implementation IWPicAndTextMessageDiagnoseSelectPickedView
+ (instancetype)IWPicAndTextMessageDiagnoseSelectPickedViewWithFrame:(CGRect)frame{
    IWPicAndTextMessageDiagnoseSelectPickedView *view = [[IWPicAndTextMessageDiagnoseSelectPickedView  alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    [view leftButton];
    [view rightButton];
    [view bottomLineView];
    
    return view;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    CGFloat buttonWidth = CGRectGetWidth(self.frame)/2;
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(@(buttonWidth));
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(@(buttonWidth));
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(2));
        make.bottom.equalTo(self.mas_bottom);
        //        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(@(buttonWidth));
    }];
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIButton *)leftButton{
    if (_leftButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:IWGlobalColor forState:UIControlStateNormal];
        button.tag=0;
        button.titleLabel.font = IWFont;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _leftButton=button;
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (_rightButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag=1;
        button.titleLabel.font = IWFont;

        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _rightButton=button;
    }
    return _rightButton;
}
-(UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = IWGlobalColor;
        [self addSubview:view];
        _bottomLineView = view;
    }
    return _bottomLineView;
}



#pragma mark - 事件处理
-(void)buttonClicked:(UIButton *)button{
    if (_buttonTapBlock) {
        _buttonTapBlock(button.tag);
    }
    
    switch (button.tag) {
        case 0:
        {
            [_leftButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
            [_rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            
            [_bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(2));
                make.bottom.equalTo(self.mas_bottom);
                make.left.equalTo(self.mas_left);
                make.width.mas_equalTo(@(CGRectGetWidth(self.frame)/2));
            }];
        }
            break;
        case 1:
        {
            [_leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_rightButton setTitleColor:IWGlobalColor forState:UIControlStateNormal];
            
            [_bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(2));
                make.bottom.equalTo(self.mas_bottom);
                make.left.equalTo(self.mas_left).offset(CGRectGetWidth(self.frame)/2);
                make.width.mas_equalTo(@(CGRectGetWidth(self.frame)/2));
            }];
        }
            break;
            
            
        default:
            break;
    }
    
}
#pragma mark - 数据处理
-(void)setTitleOne:(NSString *)titleOne{
    _titleOne = titleOne;
    [_leftButton setTitle:titleOne forState:UIControlStateNormal];
}
-(void)setTitleTwo:(NSString *)titleTwo{
    _titleTwo = titleTwo;
    [_rightButton setTitle:titleTwo forState:UIControlStateNormal];
}

@end
