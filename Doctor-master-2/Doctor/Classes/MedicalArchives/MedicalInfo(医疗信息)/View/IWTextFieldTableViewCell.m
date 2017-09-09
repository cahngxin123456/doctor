//
//  IWTextFieldTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWTextFieldTableViewCell.h"

@implementation IWTextFieldTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=IWTableViewBgColor;
    [cell nameLabel];
    [cell textfield];
    [cell rightLabel];
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(@(60));
    }];
    [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.rightLabel.mas_left).offset(-10);
    }];

    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(@(50));
    }];

    
    [super updateConstraints];
}
#pragma mark - 懒加载视图


-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = IWFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UILabel *)rightLabel{
    if (_rightLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = IWFont;
        label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}

-(UITextField *)textfield{
    if (_textfield == nil) {
        UITextField *textField = [[UITextField alloc]init];
        textField.backgroundColor = [UIColor whiteColor];
        textField.textAlignment = NSTextAlignmentRight;
        textField.font = IWFont;
        
        textField.textColor = [UIColor grayColor];
        textField.borderStyle =  UITextBorderStyleRoundedRect;
        [self.contentView addSubview:textField];
        _textfield = textField;
    }
    return _textfield;
}

#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}


@end
