//
//  IWProfileArowTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileArowTableViewCell.h"

@implementation IWProfileArowTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWProfileArowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell titleLabel];
    [cell resultLabel];
    [cell arrowImageView];
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
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@(12));
        make.width.mas_equalTo(@(7));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(_arrowImageView.mas_left).offset(-10);
        make.width.mas_equalTo(@(200));
    }];
    
    
    
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image =[UIImage imageNamed:@"common_icon_arrow"];
        
        [self.contentView addSubview:imgView];
        _arrowImageView = imgView;
    }
    return _arrowImageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:titleLabel];
        
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}
-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor=[UIColor grayColor];
        
        titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:titleLabel];
        
        _resultLabel= titleLabel;
    }
    return _resultLabel;
}

//#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}


@end
