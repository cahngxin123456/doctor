//
//  IWBloodPressureHeaderView.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWBloodPressureHeaderView.h"

#define LABELWIDTH (self.frame.size.width-20) / 5

@implementation IWBloodPressureHeaderView
+ (instancetype)customViewWithFrame:(CGRect)frame{
    IWBloodPressureHeaderView *view = [[IWBloodPressureHeaderView  alloc]initWithFrame:frame];
    view.backgroundColor=IWTableViewBgColor;
    view.userInteractionEnabled=YES;
    [view firstLabel];
    [view secondLabel];
    [view thirdLabel];
    
    return view;
}
#pragma mark - 懒加载视图
-(UILabel *)firstLabel{
    if (_firstLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10, 0, LABELWIDTH, 40);
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = NSLocalizedString(@"medical_monitor_high", nil);
        
        [self addSubview:label];
        _firstLabel = label;
    }
    return _firstLabel;
}


-(UILabel *)secondLabel{
    if (_secondLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(LABELWIDTH, 0, LABELWIDTH, 40);
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = NSLocalizedString(@"medical_monitor_low", nil);
        [self addSubview:label];
        _secondLabel = label;
    }
    return _secondLabel;
}

-(UILabel *)thirdLabel{
    if (_thirdLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.frame = CGRectMake(LABELWIDTH * 2, 0, LABELWIDTH, 40);
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = NSLocalizedString(@"medical_monitor_rate", nil);
        [self addSubview:label];
        _thirdLabel = label;
    }
    return _thirdLabel;
}
//#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}






@end
