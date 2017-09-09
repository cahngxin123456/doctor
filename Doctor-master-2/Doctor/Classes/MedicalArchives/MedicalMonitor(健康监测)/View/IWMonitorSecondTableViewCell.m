//
//  IWMonitorSecondTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWMonitorSecondTableViewCell.h"

@implementation IWMonitorSecondTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView StrResource:(NSString *)rsource{
    
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWMonitorSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.strResource = rsource;
    
    [cell nameLabel];
    [cell rightLabel];
    [cell resultLabel];
    [cell bgView];
    [cell lineView];
    [cell resultView];
    
    
    
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    CGFloat Height = 51*SFXISHU;
    if ([self.strResource isEqualToString:@"2"]) {
        Height = 81*SFXISHU;

    }
    else if ([self.strResource isEqualToString:@"1"])
    {
        Height = 51*SFXISHU;
    }
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(Height);
        make.left.equalTo(self.bgView.mas_left).offset(10);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@(0.5));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_top);
        make.left.equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@(30*SFXISHU));
        make.width.mas_equalTo(@(150));
    }];
    
//    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.resultView.mas_top);
//        make.height.mas_equalTo(@(30));
//        make.width.mas_equalTo(@(80));
//        make.centerX.mas_equalTo(self.bgView.mas_centerX);
//    }];
    
    
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@(30*SFXISHU));
        make.width.mas_equalTo(@(100));
    }];
    
//    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.lineView.mas_top);
//        make.height.mas_equalTo(@(30));
//        make.width.mas_equalTo(@(130));
//        make.centerX.mas_equalTo(self.bgView.mas_centerX);
//    }];
//    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UIView *)bgView{
    if (_bgView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _bgView = view;
    }
    return _bgView;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = IWGreenColor;
        [self.bgView addSubview:view];
        _lineView = view;
    }
    return _lineView;
}

-(UIView *)resultView{
    if (_resultView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = IWGreenColor;
        [self.bgView addSubview:view];
        _resultView = view;
    }
    return _resultView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        
        [self.bgView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UILabel *)rightLabel{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = IWGreenColor;
        label.text = @"7.8nmmol/L";
        label.font = [UIFont systemFontOfSize:14];
        
        [self.bgView addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}

-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        
        label.font = [UIFont systemFontOfSize:14];
        
        [self.bgView addSubview:label];
        _resultLabel = label;
    }
    return _resultLabel;
}




#pragma mark -数据处理
- (void)setModel:(IWBloodSugerModel *)model
{
    _model = model;
    
    if (model) {
        _resultLabel.attributedText = [self attributedStringWithStringOne:model.bloodSugar StringOneColor:[UIColor redColor] StringOneFont:[UIFont systemFontOfSize:16] StringTwo:@"nmmol/L" StringTwoColor:[UIColor grayColor] StringTwoFont:IWFont];
        _nameLabel.text = [NSString stringWithFormat:@"%@:",model.period];
        if ([model.bloodSugar floatValue] < 7.8) {
            
            [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.lineView.mas_bottom);
                make.height.mas_equalTo(@((78-[model.bloodSugar intValue]*10)*SFXISHU));
                make.width.mas_equalTo(@(130));
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
            }];
            
            [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.resultView.mas_bottom);
                make.height.mas_equalTo(@(30*SFXISHU));
                make.width.mas_equalTo(@(80));
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
            }];
        }else{
            [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bgView.mas_top).offset(81*SFXISHU);
                make.left.equalTo(self.bgView.mas_left).offset(10);
                make.right.equalTo(self.bgView.mas_right).offset(-10);
                make.height.mas_equalTo(@(0.5));
                
            }];

            
            [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.lineView.mas_bottom);
                make.height.mas_equalTo(@(([model.bloodSugar intValue]*10-78)*SFXISHU));
                make.width.mas_equalTo(@(130));
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
            }];
            
            [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.resultView.mas_top);
                make.height.mas_equalTo(@(30*SFXISHU));
                make.width.mas_equalTo(@(80));
                make.centerX.mas_equalTo(self.bgView.mas_centerX);
            }];
            _resultView.backgroundColor = IWColor(223, 122, 1);
        }
    }
}

//返回一个属性不同的字符串
-(NSMutableAttributedString *)attributedStringWithStringOne:(NSString *)stringOne StringOneColor:(UIColor *)stringOneColor StringOneFont:(UIFont *)stringOneFont StringTwo:(NSString *)stringTwo StringTwoColor:(UIColor *)stringTwoColor StringTwoFont:(UIFont *)stringTwoFont{
    
    NSString *text=[NSString stringWithFormat:@"%@%@",stringOne,stringTwo];
    
    NSMutableDictionary *attributesOne= [NSMutableDictionary dictionary];
    attributesOne[NSForegroundColorAttributeName] = stringOneColor;
    attributesOne[NSFontAttributeName] = stringOneFont;
    NSMutableDictionary *attributesTwo= [NSMutableDictionary dictionary];
    attributesTwo[NSForegroundColorAttributeName] = stringTwoColor;
    attributesTwo[NSFontAttributeName] = stringTwoFont;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedText setAttributes:attributesOne range:[text rangeOfString:stringOne]];
    [attributedText setAttributes:attributesTwo range:[text rangeOfString:stringTwo]];
    
    return attributedText;
}

@end
