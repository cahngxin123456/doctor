//
//  IWProfileSFTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/22.
//
//

#import "IWProfileSFTableViewCell.h"

@implementation IWProfileSFTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWProfileSFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
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
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(@(7));
        make.height.mas_equalTo(@(13));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.rightimageView.mas_left).offset(-10);
    }];
    
    
    [super updateConstraints];
}
#pragma mark - 懒加载视图
-(UIImageView *)rightimageView{
    if (_rightimageView == nil) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds=YES;
        
        imgView.image = [UIImage imageNamed:@"xuanze"];
        imgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imgView];
        _rightimageView = imgView;
    }
    return _rightimageView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _titleLabel= titleLabel;
    }
    return _titleLabel;
}
#pragma mark -数据处理

- (void)setCommunitymodel:(IWprofileCommunityModel *)communitymodel{
    _communitymodel = communitymodel;
    
    _titleLabel.text = communitymodel.communityName;
}

- (void)setProvinceModel:(IWprofileProvinceModel *)provinceModel{
    _provinceModel = provinceModel;
    
    _titleLabel.text = provinceModel.regionName;
    _rightimageView.hidden = YES;
}

- (void)setCityModel:(IWProfileCityModel *)cityModel{
    _cityModel = cityModel;
    _titleLabel.text = cityModel.regionName;
    _rightimageView.hidden = YES;
}

@end
