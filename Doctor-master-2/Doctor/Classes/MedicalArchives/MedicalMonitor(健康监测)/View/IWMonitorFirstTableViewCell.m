//
//  IWMonitorFirstTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWMonitorFirstTableViewCell.h"


@implementation IWMonitorFirstTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWMonitorFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell nameLabel];
    [cell leftView];
    [cell rightView];
    [cell topLabel];
    [cell bottomView];
    [cell bottomLabel];
    [cell resultView];
    [cell centerLabel];
    [cell bgView];
    
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
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top).offset(70*SFXISHU);
        make.left.equalTo(self.bgView.mas_left).offset(10*SFXISHU);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@(50 * SFXISHU));
    }];

    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bgView.mas_left).offset(10);
        make.height.mas_equalTo(@(30 * SFXISHU));
        make.width.mas_equalTo(@(50));
        
    }];
    
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top);
        make.height.mas_equalTo(@(30 *SFXISHU));
        make.width.mas_equalTo(@(80));
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
    }];
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomView.mas_top);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@(30*SFXISHU));
        make.width.mas_equalTo(@(70));
    }];
    
    
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom);
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.height.mas_equalTo(@(30*SFXISHU));
        make.width.mas_equalTo(@(70));
    }];
    
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(0.5);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-0.5);
        make.left.equalTo(self.bottomView.mas_left);
        make.width.mas_equalTo(@(60));
    }];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(0.5);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-0.5);
        make.right.equalTo(self.bottomView.mas_right);
        make.width.mas_equalTo(@(60));
        
    }];
    
//    [_resultView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.bottomView.mas_bottom);
//        make.height.mas_equalTo(@(30*SFXISHU));
//        make.width.mas_equalTo(@(130));
//        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
//    }];
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UIImageView *)bgView{
    if (_bgView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imgView];
        _bgView = imgView;
    }
    return _bgView;
}
-(UIImageView *)bottomView{
    if (_bottomView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = IWGreenColor;
        [self.bgView addSubview:imgView];
        _bottomView = imgView;
    }
    return _bottomView;
}
-(UIImageView *)leftView{
    if (_leftView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor whiteColor];
        [self.bottomView addSubview:imgView];
        _leftView = imgView;
    }
    return _leftView;
}
-(UIImageView *)rightView{
    if (_rightView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor whiteColor];
        [self.bottomView addSubview:imgView];
        _rightView = imgView;
    }
    return _rightView;
}
-(UIImageView *)resultView{
    if (_resultView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor redColor];
        [self.bottomView addSubview:imgView];
        _resultView = imgView;
    }
    return _resultView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"收缩压:";
        [self.bgView addSubview:titleLabel];
        _nameLabel= titleLabel;
    }
    return _nameLabel;
}
-(UILabel *)topLabel{
    if (_topLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=IWGreenColor;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = @"140mmhg";
        [self.bgView addSubview:titleLabel];
        _topLabel= titleLabel;
    }
    return _topLabel;
}
-(UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=IWGreenColor;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = @"90mmhg";
        [self.bgView addSubview:titleLabel];
        _bottomLabel= titleLabel;
    }
    return _bottomLabel;
}
-(UILabel *)centerLabel{
    if (_centerLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=IWGreenColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:titleLabel];
        _centerLabel= titleLabel;
    }
    return _centerLabel;
}

#pragma mark -数据处理
- (void)setModel:(IWBloodPressureModel *)model
{
    _model = model;
    
    if (model) {
        _centerLabel.textColor = IWGreenColor;

        if ([model.highPresure intValue] <=90) {
            
            [_resultView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@((90-[model.highPresure intValue])*SFXISHU));
                make.top.equalTo(self.bottomView.mas_bottom);
                make.width.mas_equalTo(@(130));
                make.centerX.mas_equalTo(self.bottomView.mas_centerX);
            }];
            _resultView.backgroundColor = IWColor(223, 122, 32);
            _centerLabel.attributedText = [self attributedStringWithStringOne:model.lowPressure StringOneColor:[UIColor redColor] StringOneFont:[UIFont systemFontOfSize:16] StringTwo:@"mmHg" StringTwoColor:[UIColor grayColor] StringTwoFont:IWFont];
        }else if ([model.highPresure intValue] >= 140){
            [_resultView mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(@(([model.highPresure intValue]-140)>21?21:([model.highPresure intValue]-140)*SFXISHU));
                make.bottom.equalTo(self.bottomView.mas_top);
                make.width.mas_equalTo(@(130));
                make.centerX.mas_equalTo(self.bottomView.mas_centerX);
            }];
            _resultView.backgroundColor = IWColor(223, 122, 32);
            _centerLabel.textColor = [UIColor redColor];
            _centerLabel.attributedText = [self attributedStringWithStringOne:model.lowPressure StringOneColor:[UIColor redColor] StringOneFont:[UIFont systemFontOfSize:16] StringTwo:@"mmHg" StringTwoColor:[UIColor grayColor] StringTwoFont:IWFont];
        }else{
            [_resultView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(([model.highPresure intValue] -90)*SFXISHU));
                make.bottom.equalTo(self.bottomView.mas_bottom);
                make.width.mas_equalTo(@(130));
                make.centerX.mas_equalTo(self.bottomView.mas_centerX);
            }];
            _resultView.backgroundColor = IWColor(107, 174, 1);
            
            
        }
        _centerLabel.text = [NSString stringWithFormat:@"%@mmHg",model.highPresure];

        
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
