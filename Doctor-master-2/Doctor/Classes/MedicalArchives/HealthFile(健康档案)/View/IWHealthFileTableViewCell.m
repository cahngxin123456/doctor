//
//  IWHealthFileTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/18.
//
//

#import "IWHealthFileTableViewCell.h"

#define Gap 10

@implementation IWHealthFileTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWHealthFileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell iconImageView];
    [cell nameLabel];
    [cell sexImageView];
    [cell arrowImageView];
    [cell familyLabel];
    [cell firstButton];
    [cell secondButton];
    [cell thirdButton];
    [cell leftLineView];
    [cell rightLineView];
    [cell lineView];
    return cell;
}

#pragma mark - 懒加载视图


-(UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 30;
        [self.contentView addSubview:imageView];
        _iconImageView = imageView;
    }
    return _iconImageView;
}
-(UIImageView *)sexImageView{
    if (_sexImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _sexImageView = imageView;
    }
    return _sexImageView;
}

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UILabel *)familyLabel{
    if (_familyLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        _familyLabel = label;
    }
    return _familyLabel;
}
-(UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [self.contentView addSubview:imageView];
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}

-(UIButton *)firstButton{
    
    
    if (_firstButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag=0;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"健康监测" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"jkcs_btn_normal"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [button setImage:[UIImage imageNamed:@"jkcs_btn_press"] forState:UIControlStateHighlighted];
        
        
        [self.contentView addSubview:button];
        _firstButton=button;
    }
    return _firstButton;
}

-(UIButton *)secondButton{
    if (_secondButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"病例/报告" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"baogao_btn_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"baogao_btn_press"] forState:UIControlStateHighlighted];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:button];
        _secondButton=button;
    }
    return _secondButton;
}

-(UIView *)leftLineView{
    if (_leftLineView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.2;
        [self.contentView addSubview:view];
        _leftLineView = view;
    }
    return _leftLineView;
}

-(UIView *)rightLineView{
    if (_rightLineView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.2;
        [self.contentView addSubview:view];
        _rightLineView = view;
    }
    return _rightLineView;
}

-(UIView *)lineView{
    if (_lineView == nil) {
        UIView *view =[[UIView alloc]init];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.2;
        [self.contentView addSubview:view];
        _lineView = view;
    }
    return _lineView;
}

-(UIButton *)thirdButton{
    if (_thirdButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        button.tag=2;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"医疗信息" forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"xx_btn_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"xx_btn_press"] forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        [self.contentView addSubview:button];
        
        _thirdButton=button;
    }
    return _thirdButton;
}
//点击事件
-(void)buttonClicked:(UIButton *)button{
    UIButton *btn = button;
    if (btn.tag == 0) {
        if (_firstBtnBlock) {
            _firstBtnBlock();
        }
    }else if (btn.tag == 1)
    {
        if (_secondBtnBlock) {
            _secondBtnBlock();
        }
    }else
    {
        if (_thirdBtnBlock) {
            _thirdBtnBlock();
        }
    }
    
}


+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


-(void)updateConstraints{
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(Gap);
        make.left.equalTo(self.contentView.mas_left).offset(Gap);
        make.width.mas_equalTo(@(60));
        make.height.mas_equalTo(@(60));
        
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_top);
        make.left.equalTo(_iconImageView.mas_right).offset(Gap);
        make.width.mas_equalTo(@(46));
        make.height.mas_equalTo(@(20));
        
    }];
    
    [_familyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconImageView.mas_bottom).offset(-5);
        make.left.equalTo(_nameLabel.mas_left);
        make.width.mas_equalTo(@(30));
        make.height.mas_equalTo(@(20));
        
    }];
    
    [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_top);
        make.left.equalTo(_nameLabel.mas_right).offset(Gap - 5);
        make.width.mas_equalTo(@(18));
        make.height.mas_equalTo(@(18));
        
        
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(_iconImageView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-Gap);
        make.width.mas_equalTo(@(12));
        make.height.mas_equalTo(@(12));
        
    }];
    
    
    [_firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_iconImageView.mas_bottom).offset(Gap);
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(@(self.contentView.frame.size.width / 3));
        make.height.mas_equalTo(@(40));
    }];
    
    [_thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_firstButton.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(@(self.contentView.frame.size.width / 3));
        make.height.mas_equalTo(@(40));
        
        
        
    }];
    
    [_secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstButton.mas_top);
        make.left.equalTo(_firstButton.mas_right);
        make.right.equalTo(_thirdButton.mas_left);
        make.height.mas_equalTo(@(40));
        
    }];
    
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(self.contentView.frame.size.width / 3);
        make.width.mas_equalTo(@(0.5));
        make.height.mas_equalTo(@(40));
        make.top.equalTo(_firstButton.mas_top);
    }];
    
    [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_secondButton.mas_right);
        make.width.mas_equalTo(@(0.5));
        make.height.mas_equalTo(@(40));
        make.top.equalTo(_firstButton.mas_top);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(@(self.contentView.frame.size.width));
        make.height.mas_equalTo(@(0.5));
        make.top.equalTo(_firstButton.mas_top);
    }];
    
    
    //    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.contentView.mas_top);
    //        make.bottom.equalTo(self.contentView.mas_bottom);
    //        make.left.equalTo(self.contentView.mas_left);
    //        make.right.equalTo(self.contentView.mas_right);
    //        make.height.mas_equalTo(@(50));
    //        make.width.mas_equalTo(@(50));
    //        make.width.equalTo(_imgView.mas_height);
    //        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    //        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    //    }];
    [super updateConstraints];
}




#pragma mark -数据处理
- (void)setModel:(IWHealhFileModel *)model
{
    _model = model;
    
    if (model.photo == nil || [@"" isEqualToString:model.photo]) {
        [self.iconImageView setImage:[UIImage imageWithName:@"90boy"]];
    } else {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]];
    }
    
    
    self.nameLabel.text = model.name;
    
    if ([model.relationship intValue]== 0) {
        self.familyLabel.text = @"本人";
    }else if ([model.relationship intValue]== 1)
    {
        self.familyLabel.text = @"家人";
    }else{
        self.familyLabel.text = @"其他";
        
    }
    
    if ([model.gender isEqualToString:@"男"]) {
        self.sexImageView.image = [UIImage imageNamed:@"user_gender_male"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"user_gender_female"];
        
    }
    
    
}



@end
