//
//  IWProfileNormalTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileNormalTableViewCell.h"

@implementation IWProfileNormalTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWProfileNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    [cell titleLabel];
    [cell resultLabel];
    [cell arrowImageView];
    //    [cell newsTextField];
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
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(@(50));
        
    }];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.height.mas_equalTo(@(30));
        make.width.mas_equalTo(@(20));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(_arrowImageView.mas_right);
        make.width.mas_equalTo(@(300));
    }];
    
    [_newsTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.width.mas_equalTo(@(330));
        
    }];
    
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgView];
        _arrowImageView = imgView;
    }
    return _arrowImageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}
-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor=[UIColor blackColor];
        [self.contentView addSubview:titleLabel];
        
        _resultLabel= titleLabel;
    }
    return _resultLabel;
}

- (UITextField *)newsTextField
{
    if (_newsTextField == nil) {
        UITextField *textField = [[UITextField alloc] init];
        textField.backgroundColor = [UIColor redColor];
        textField.placeholder = @"sssss";
        textField.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:textField];
        _newsTextField = textField;
        
        
    }
    return _newsTextField;
}

//#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}



@end
