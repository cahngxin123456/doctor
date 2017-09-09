//
//  IWProfileTextFieldTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileTextFieldTableViewCell.h"



@implementation IWProfileTextFieldTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWProfileTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell titleLabel];
    [cell newsTextField];
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(@(150));
        
    }];
    
    
    [_newsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-13);
        make.width.mas_equalTo(@(200));
        
    }];
    
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titleLabel];
        
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}


- (UITextField *)newsTextField
{
    if (_newsTextField == nil) {
        UITextField *textField = [[UITextField alloc] init];
        textField.textColor = [UIColor grayColor];
        textField.tintColor = [UIColor whiteColor];
        //        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:14];
        //        textField.placeholder = @"请输入你需要的地址";
        textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:textField];
        _newsTextField = textField;
    }
    return _newsTextField ;
}


//#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}


@end
