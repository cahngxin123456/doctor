//
//  IWProfileIconTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWProfileIconTableViewCell.h"

@implementation IWProfileIconTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWProfileIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    [cell iconImageView];
    return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(50));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        imgView.layer.cornerRadius = 25;
        
        imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgView];
        _iconImageView = imgView;
    }
    return _iconImageView;
}

//#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
