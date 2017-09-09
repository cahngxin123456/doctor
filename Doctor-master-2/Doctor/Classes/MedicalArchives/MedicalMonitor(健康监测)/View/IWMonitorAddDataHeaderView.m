//
//  IWMonitorAddDataHeaderView.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWMonitorAddDataHeaderView.h"

@implementation IWMonitorAddDataHeaderView

+ (instancetype)customViewWithFrame:(CGRect)frame andTitle:(NSString *)title{
    IWMonitorAddDataHeaderView *view = [[IWMonitorAddDataHeaderView  alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    view.userInteractionEnabled=YES;
    view.title = title;

    view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
    [view pressButton];
    [view titleLabel];
    return view;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_pressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(30);
        make.height.mas_equalTo(@(150));
        make.width.mas_equalTo(@(150));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.mas_equalTo(@(40));
        make.width.mas_equalTo(@(200));
    }];

    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UIButton *)pressButton{
    if (_pressButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.title isEqualToString:@"BloodPressure"]) {
            [button setTitle:NSLocalizedString(@"medical_monitor_pressure_tip", nil) forState:UIControlStateNormal];
        }else{
            [button setTitle:NSLocalizedString(@"medical_monitor_blood_tip", nil) forState:UIControlStateNormal];

        }
        
        [button setTitleColor:IWColor(172, 3, 3) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setBackgroundImage:[UIImage imageNamed:@"cl_btn_normal"] forState:UIControlStateNormal];

        [button setBackgroundImage:[UIImage imageNamed:@"cl_btn_press"] forState:UIControlStateHighlighted];

        [self addSubview:button];
        _pressButton=button;
    }
    return _pressButton;
}
//点击事件
-(void)buttonClicked:(UIButton *)button{
    if (_buttonBlock) {
        _buttonBlock(self.title);
    }
}

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=IWBlueColor;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        if ([self.title isEqualToString: @"BloodPressure"]) {
            titleLabel.text = NSLocalizedString(@"medical_monitor_pressure_knoweledge1", nil);
            
        }else{
            titleLabel.text = NSLocalizedString(@"medical_monitor_blood_knoweledge1", nil);
        }
        [self addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}
#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}

@end
