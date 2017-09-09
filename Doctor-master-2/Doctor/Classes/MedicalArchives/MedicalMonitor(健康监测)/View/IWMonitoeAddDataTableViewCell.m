//
//  IWMonitoeAddDataTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IWMonitoeAddDataTableViewCell.h"

@implementation IWMonitoeAddDataTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWMonitoeAddDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    [cell rightimageView];
    [cell titleLabel];
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_rightimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(@(12));
        make.width.mas_equalTo(@(12));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(@(300));
    }];

    
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIImageView *)rightimageView{
    if (_rightimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.backgroundColor = [UIColor clearColor];
        imgView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [self.contentView addSubview:imgView];
        _rightimageView = imgView;
    }
    return _rightimageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:titleLabel];
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

- (void)setNameTitle:(NSString *)nameTitle{
    _nameTitle = nameTitle;
    _titleLabel.text = nameTitle;
    
}


@end
