//
//  IWInfoTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/19.
//
//

#import "IWInfoTableViewCell.h"

@implementation IWInfoTableViewCell


+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView indexpath:(NSIndexPath *)index{
    NSString *className = NSStringFromClass([self class]);
    NSString *cellID = [NSString stringWithFormat:@"%d%d",index.section,index.row];
    [tableView registerClass:[self class] forCellReuseIdentifier:cellID];
    IWInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell bgView];
    [cell titleLabel];
    [cell resultLabel];
    [cell editImageView];
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self bgView];
        [self titleLabel];
        [self resultLabel];
        [self editImageView];
    }
    return self;
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
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_top);
        make.bottom.equalTo(self.bgView.mas_bottom);
        make.left.equalTo(self.bgView.mas_left).offset(5);
        make.height.mas_equalTo(@(50));
        make.width.mas_equalTo(@(60));
    }];
    
    [_editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-5);
        make.height.mas_equalTo(@(12));
        make.width.mas_equalTo(@(7));
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    [_resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.editImageView.mas_top);
        make.bottom.equalTo(self.editImageView.mas_bottom);
        make.right.equalTo(self.editImageView.mas_left).offset(-5);

        make.left.equalTo(self.titleLabel.mas_right).offset(10);
    }];
    
    
    
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
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}

-(UILabel *)resultLabel{
    if (_resultLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:titleLabel];
        _resultLabel= titleLabel;
    }
    return _resultLabel;
}
-(UIImageView *)editImageView{
    if (_editImageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.hidden = NO;
        imgView.image = [UIImage imageNamed:@"xiugai_btn"];
        [self.bgView addSubview:imgView];
        _editImageView = imgView;
    }
    return _editImageView;
}

#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}



@end
