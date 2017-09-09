//
//  IwBloodPressureDataTableViewCell.m
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import "IwBloodPressureDataTableViewCell.h"

#define LABELWIDTH (self.contentView.frame.size.width-13)/5
#define  KHeight 40.0
#define  KImgHeight 15
#define  KImgWeight 7


@implementation IwBloodPressureDataTableViewCell

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IwBloodPressureDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor whiteColor];
    [cell firstLabel];
    [cell secondLabel];
    [cell thirdabel];
    [cell forthLabel];
    [cell viewOfRemark];
    [cell imageViewOf1];
    [cell imageViewOf2];
        return cell;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
//-(void)updateConstraints{
//    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.width.mas_equalTo(@(LABELWIDTH));
//        
//    }];
//    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.firstLabel.mas_right);
//        make.width.mas_equalTo(@(LABELWIDTH));
//    }];
//    
//    [_thirdabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.secondLabel.mas_right);
//        make.width.mas_equalTo(@(LABELWIDTH));
//    }];
//    
//    [_forthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.thirdabel.mas_right);
//        make.width.mas_equalTo(@(LABELWIDTH * 2));
//
//    }];
//    [super updateConstraints];
//}
-(void)updateConstraints{
    [_firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(@(LABELWIDTH));
        make.height.offset(KHeight);
        
    }];
//    [_imageViewOf1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top).offset(10);
//        //        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.firstLabel.mas_right).offset(-20);
//        make.width.offset(KImgWeight);
//        make.height.offset(KImgHeight);
//        
//    }];
    [_secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.firstLabel.mas_right);
        make.width.mas_equalTo(@(LABELWIDTH));
        make.height.offset(KHeight);

    }];
    
//    [_imageViewOf2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView.mas_top);
//        //        make.bottom.equalTo(self.contentView.mas_bottom);
//        make.left.equalTo(self.secondLabel.mas_right).offset(0);
//        make.width.offset(KImgWeight);
//        make.height.offset(KImgHeight);
//        
//    }];
    
    [_thirdabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.secondLabel.mas_right);
        make.width.mas_equalTo(@(LABELWIDTH));
        make.height.offset(KHeight);

    }];
    
    [_forthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
//        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.thirdabel.mas_right);
        make.width.mas_equalTo(@(LABELWIDTH * 2));
        make.height.offset(KHeight);

        
    }];
    [super updateConstraints];
}

#pragma mark - 懒加载视图
-(UILabel *)firstLabel{
    if (_firstLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _firstLabel= titleLabel;
    }
    return _firstLabel;
}
-(UILabel *)secondLabel{
    if (_secondLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _secondLabel= titleLabel;
    }
    return _secondLabel;
}
-(UILabel *)thirdabel{
    if (_thirdabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        _thirdabel= titleLabel;
    }
    return _thirdabel;
}
-(UILabel *)forthLabel{
    if (_forthLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor=IWBlueColor;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleLabel];
        
        _forthLabel= titleLabel;
    }
    return _forthLabel;
}
- (UIView *)viewOfRemark
{
    if (_viewOfRemark == nil) {
        _viewOfRemark = [[UIView alloc] init];
        [self.contentView addSubview:_viewOfRemark];
    }
    for (UIView *lb in _viewOfRemark.subviews) {
        if ([lb isKindOfClass:[UILabel class]]) {
            if (lb.tag == 2) {
                [lb removeFromSuperview];
            }
        }
    }
    return _viewOfRemark;
    
}
- (UIImageView *)imageViewOf1
{
    if (_imageViewOf1 == nil) {
        _imageViewOf1 = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageViewOf1];
    }
    return _imageViewOf1;
}
- (UIImageView *)imageViewOf2
{
    if (_imageViewOf2 == nil) {
        _imageViewOf2 = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageViewOf2];
    }
    return _imageViewOf2;
}



#pragma mark -数据处理
- (void)setModel:(IWBloodPressureDetalModel *)model
{
    _model = model;
    self.imageViewOf1.hidden =YES;
    self.imageViewOf2.hidden = YES;
    
    self.viewOfRemark.hidden =YES;

    CGFloat distance=35;
    CGFloat distance2=105;

    if ([UIScreen mainScreen].bounds.size.width ==320) {
        distance=35;
        distance2 = 98;
    }
    else if ([UIScreen mainScreen].bounds.size.width ==375)
    {
        distance=35;
        distance2 = 105;
    }
    else if ([UIScreen mainScreen].bounds.size.width >375)
    {
        distance=40;
        distance2 = 110;
    }

    self.imageViewOf1.frame = CGRectMake(distance, 12, KImgWeight, KImgHeight);
    self.imageViewOf2.frame = CGRectMake(distance2, 12, KImgWeight, KImgHeight);

    if ([_model.highPresure intValue] > 140) {
        _firstLabel.textColor = [UIColor redColor];
        self.imageViewOf1.hidden = NO;
        self.imageViewOf1.image = [UIImage imageNamed:@"gao"];
    }else if ([_model.highPresure intValue] < 90 ){
        _firstLabel.textColor = [UIColor blackColor];
        self.imageViewOf1.hidden = NO;
        self.imageViewOf1.image = [UIImage imageNamed:@"di"];
    }else{
    
        _firstLabel.textColor = IWGreenColor;
    }
    
    if ([_model.lowPressure intValue] > 90) {
        _secondLabel.textColor = [UIColor redColor];
        self.imageViewOf2.hidden = NO;
        self.imageViewOf2.image = [UIImage imageNamed:@"gao"];
    }else if ([_model.lowPressure intValue] < 60)
    {
        _secondLabel.textColor = [UIColor blackColor];
        self.imageViewOf2.hidden = NO;
        self.imageViewOf2.image = [UIImage imageNamed:@"di"];

    }else{
        _secondLabel.textColor = IWGreenColor;
    }
    
    
    
    _firstLabel.text = _model.highPresure;
    _secondLabel.text = _model.lowPressure;
    _thirdabel.text = _model.heartRate;
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    //先设置给定的字符串是什么格式的例如yyyyMMddHHmmss
    [dateFormat1 setLocale:[NSLocale currentLocale]];
    [dateFormat1 setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormat1 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSDate *date1 = [dateFormat1 dateFromString:_model.insertTime];
    //将日期转为指定格式
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc]init];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"zyc"]];
    [dateFormat2 setLocale:[NSLocale currentLocale]];
    //将NSDate格式时间转成什么格式的字符串例如转成M-d
    [dateFormat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat2 setFormatterBehavior:NSDateFormatterBehaviorDefault];
    NSString *timeStr = [dateFormat2 stringFromDate:date1];
    _forthLabel.text = timeStr;
    
    if (model.remark !=nil && model.remark.length>0 ) {
        self.viewOfRemark.hidden =NO;
        self.viewOfRemark.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40);
        UILabel *lbOfSeperate = [[UILabel alloc] init];
        lbOfSeperate.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        lbOfSeperate.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1);
        [self.viewOfRemark addSubview:lbOfSeperate];
        
        UILabel *lb1 = [[UILabel alloc] init];
        lb1.tag = 1;
        lb1.text = @"备注:";
        lb1.textColor =IWColor(150,150,150);
        [lb1 setFont:[UIFont systemFontOfSize:13]];
        CGRect boundslbOfRemark = [lb1.text getTextWidthAndHeightWithFont:lb1.font.pointSize withWidth:999999];
        lb1.frame = CGRectMake(5,(KHeight -boundslbOfRemark.size.height)/2  , boundslbOfRemark.size.width, boundslbOfRemark.size.height);
        [self.viewOfRemark addSubview:lb1];
        
        UILabel *lb2 = [[UILabel alloc] init];
        lb2.tag = 2;
//        lb2.numberOfLines = 2;
        lb2.text = model.remark;

        lb2.textColor =IWColor(70,70,70);
        [lb2 setFont:[UIFont systemFontOfSize:13]];
        CGRect boundslb2 = [lb2.text getTextWidthAndHeightWithFont:lb2.font.pointSize withWidth:99999];
        lb2.frame = CGRectMake(CGRectGetMaxX(lb1.frame)+5,lb1.frame.origin.y , boundslb2.size.width>([UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(lb1.frame)-5)?([UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(lb1.frame)-5):boundslb2.size.width, boundslb2.size.height);
        [self.viewOfRemark addSubview:lb2];
        
    }
    else{
        self.viewOfRemark.hidden =YES;

    }
    
}


@end
