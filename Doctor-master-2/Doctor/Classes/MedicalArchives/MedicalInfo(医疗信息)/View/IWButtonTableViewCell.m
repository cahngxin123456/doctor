//
//  IWButtonTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWButtonTableViewCell.h"

@implementation IWButtonTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor=IWTableViewBgColor;
    [cell whiteView];

    [cell nameLabel];
    [cell resultLabel];
    [cell arrowImageView];
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
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.width.mas_equalTo(@(12));
        make.height.mas_equalTo(@(12));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);

    }];

    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.nameLabel.mas_right);
        make.right.equalTo(self.arrowImageView.mas_left).offset(-10);
    }];
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultLabel.mas_top);
        make.bottom.equalTo(self.resultLabel.mas_bottom);
        make.left.equalTo(self.resultLabel.mas_left);
        make.right.equalTo(self.resultLabel.mas_right).offset(25);

    }];
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.font = IWFont;
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor grayColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius= 3;
        
        label.font = IWFont;
        label.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:label];
        [self.contentView bringSubviewToFront:label];
        _resultLabel = label;
    }
    return _resultLabel;
}

-(UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"common_icon_arrow"];
        [self.contentView addSubview:imageView];
        [self.contentView bringSubviewToFront:imageView];
        _arrowImageView = imageView;
    }
    return _arrowImageView;
}

- (UIView *)whiteView{
    if (_whiteView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        _whiteView = view;
    }
    return _whiteView;
}


#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}



@end
