//
//  IWMedicalMointorSugarTableViewCell.m
//  Doctor
//
//  Created by 雷王 on 17/1/7.
//
//

#import "IWMedicalMointorSugarTableViewCell.h"
#define  KSeparate 10
#define KRectangularW 82
#define KRectangularH 30

#define KLimit  45

#define IWSeparateColor IWColor(100,157,3)


@implementation IWMedicalMointorSugarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)normalTableViewCellWithTableView:(UITableView *)tableView{
    NSString *className = NSStringFromClass([self class]);
    [tableView registerClass:[self class] forCellReuseIdentifier:className];
    IWMedicalMointorSugarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initUI];
    
    return cell;
}

//初始化控件
- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (!self.lbOfSeprate) {
        self.lbOfSeprate = [[UILabel alloc] init];
    }
    self.lbOfSeprate.backgroundColor = IWTableViewBgColor;
    [self.contentView addSubview:self.lbOfSeprate];
    if (!self.lbOfTime) {
        self.lbOfTime = [[UILabel alloc] init];
    }
    [self.lbOfTime setFont:[UIFont systemFontOfSize:12]];
    self.lbOfTime.textColor = IWColor(80,129,154);
    [self.contentView addSubview:self.lbOfTime];
    
    if (!self.lbOfEat) {
        self.lbOfEat = [[UILabel alloc] init];
    }
    [self.lbOfEat setFont:[UIFont systemFontOfSize:12]];
    self.lbOfEat.textColor =IWColor(80,80,80);
    [self.contentView addSubview:self.lbOfEat];
    
    if (!self.viewOfMedical) {
        self.viewOfMedical = [[UIView alloc] init];
    }
    [self.contentView addSubview:self.viewOfMedical];
    
    if (!self.lbOfMedical) {
        self.lbOfMedical = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfMedical];
    
    if (!self.lbOfMedicalM) {
        self.lbOfMedicalM = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfMedicalM];
    
    if (!self.lbOfMedicalNumber) {
        self.lbOfMedicalNumber = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfMedicalNumber];
    
    if (!self.lbOfRemark) {
        self.lbOfRemark = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfRemark];
    
    if (!self.lbOfRemarkContent) {
        self.lbOfRemarkContent = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfRemarkContent];
    
    if (!self.lbOfSeprateRemark) {
        self.lbOfSeprateRemark = [[UILabel alloc] init];
    }
    [self.contentView addSubview:self.lbOfSeprateRemark];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lbOfSeprate.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, KSeparate);
    
    self.lbOfTime.text = _model.measureTime;
    CGRect bounds1 = [self.lbOfTime.text getTextWidthAndHeightWithFont:self.lbOfTime.font.pointSize withWidth:999999];
    self.lbOfTime.frame = CGRectMake(0, CGRectGetMaxY(self.lbOfSeprate.frame), bounds1.size.width, bounds1.size.height);
    
    self.lbOfEat.text = _model.period;
    CGRect bounds2 = [self.lbOfEat.text getTextWidthAndHeightWithFont:self.lbOfEat.font.pointSize withWidth:999999];
    self.lbOfEat.frame = CGRectMake(CGRectGetMaxX(self.lbOfTime.frame)+3, self.lbOfTime.frame.origin.y, bounds2.size.width, bounds2.size.height);
    
    
    UILabel *lbwwww = [[UILabel alloc] init];
    lbwwww.text = @"7.8mmol/L";
    lbwwww.textColor = IWGreenColor;
    [lbwwww setFont:[UIFont systemFontOfSize:18]];
    CGRect boundsw = [lbwwww.text getTextWidthAndHeightWithFont:18 withWidth:999999];
    CGFloat distance=45;
    if ([UIScreen mainScreen].bounds.size.width ==320) {
        distance=45;
    }
else if ([UIScreen mainScreen].bounds.size.width ==375)
{
    distance=80;
}
else if ([UIScreen mainScreen].bounds.size.width >375)
{
    distance=90;
}

    self.viewOfMedical.frame = CGRectMake(distance + boundsw.size.width, CGRectGetMaxY(self.lbOfTime.frame)+3, KRectangularW, KRectangularH);
    UILabel *lb1 = [[UILabel alloc] init];
    lb1.frame = CGRectMake(0, 0, 1, KRectangularH);
    if ([_model.bloodSugar isEqualToString:@"7.8"] || [_model.bloodSugar doubleValue] == 7.8) {
        lb1.backgroundColor = IWColor(250,139,64);
        
    }
    else{
        lb1.backgroundColor = IWSeparateColor;

    }
    [self.viewOfMedical addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc] init];
    lb2.frame = CGRectMake(1, 2, KRectangularW-2, KRectangularH-4);
    lb2.backgroundColor =  IWColor(160,210,60);
    [self.viewOfMedical addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc] init];
    lb3.frame = CGRectMake(20, 0, 1, KRectangularH);
    lb3.backgroundColor = IWSeparateColor;
    [self.viewOfMedical addSubview:lb3];
    
    UILabel *lb4 = [[UILabel alloc] init];
    lb4.frame = CGRectMake(KRectangularW-1, 0, 1, KRectangularH);
//    lb4.backgroundColor = IWSeparateColor;
    if ([_model.bloodSugar isEqualToString:@"3.9"] || [_model.bloodSugar doubleValue] == 3.9) {
        lb4.backgroundColor = IWColor(250,139,64);
        
    }
    else{
        lb4.backgroundColor = IWSeparateColor;
        
    }

    [self.viewOfMedical addSubview:lb4];
    
    if ([_model.bloodSugar doubleValue] >= 7.8) {

       
        CGFloat width = ([_model.bloodSugar doubleValue]-7.8)*(80 /(7.8-3.9)/3*2);
        if (width > KLimit) {
            width = KLimit;
        }
//        CGFloat width = 20;

        self.lbOfMedical.frame = CGRectMake(self.viewOfMedical.frame.origin.x-width, self.viewOfMedical.frame.origin.y+6, width, KRectangularH-12);
        self.lbOfMedical.backgroundColor = IWColor(250,139,64);
        self.lbOfMedicalM.text = @"mmol/L";
        self.lbOfMedicalM.textColor = IWColor(150,150,150);
        [self.lbOfMedicalM setFont:[UIFont systemFontOfSize:12]];
         CGRect boundslbOfMedicalM = [self.lbOfMedicalM.text getTextWidthAndHeightWithFont:self.lbOfMedicalM.font.pointSize withWidth:999999];
        self.lbOfMedicalM.frame = CGRectMake(self.lbOfMedical.frame.origin.x - boundslbOfMedicalM.size.width - 2, self.lbOfMedical.frame.origin.y+2, boundslbOfMedicalM.size.width, boundslbOfMedicalM.size.height);
        
        self.lbOfMedicalNumber.text = _model.bloodSugar;
        self.lbOfMedicalNumber.textColor = IWColor(216,0,67);
        [self.lbOfMedicalNumber setFont:[UIFont systemFontOfSize:20]];
        CGRect boundslbOfMedicalNumber = [self.lbOfMedicalNumber.text getTextWidthAndHeightWithFont:self.lbOfMedicalNumber.font.pointSize withWidth:999999];
        self.lbOfMedicalNumber.frame = CGRectMake(self.lbOfMedicalM.frame.origin.x-boundslbOfMedicalNumber.size.width, self.lbOfMedical.frame.origin.y-5, boundslbOfMedicalNumber.size.width, boundslbOfMedicalNumber.size.height);

    }
    else{
        if ([_model.bloodSugar doubleValue] > 3.9) {
            if ([_model.bloodSugar doubleValue] > 6.0) {
//                CGFloat width = 20;
                CGFloat width = ([_model.bloodSugar doubleValue]-6.0)*(80 /(7.8-3.9))/3*2;
                if (width > 15) {
                    width = 15;
                }

                
                self.lbOfMedical.frame = CGRectMake(self.viewOfMedical.frame.origin.x+20-width, self.viewOfMedical.frame.origin.y+6, width, KRectangularH-12);
                self.lbOfMedical.backgroundColor = IWGreenColor;
                
                self.lbOfMedicalNumber.text = _model.bloodSugar;
                self.lbOfMedicalNumber.textColor = IWGreenColor;
                [self.lbOfMedicalNumber setFont:[UIFont systemFontOfSize:20]];
                CGRect boundslbOfMedicalNumber = [self.lbOfMedicalNumber.text getTextWidthAndHeightWithFont:self.lbOfMedicalNumber.font.pointSize withWidth:999999];
                self.lbOfMedicalNumber.frame = CGRectMake(CGRectGetMaxX(self.viewOfMedical.frame)+3, self.lbOfMedical.frame.origin.y-5, boundslbOfMedicalNumber.size.width, boundslbOfMedicalNumber.size.height);
                
                self.lbOfMedicalM.text = @"mmol/L";
                self.lbOfMedicalM.textColor = IWColor(150,150,150);
                [self.lbOfMedicalM setFont:[UIFont systemFontOfSize:12]];
                CGRect boundslbOfMedicalM = [self.lbOfMedicalM.text getTextWidthAndHeightWithFont:self.lbOfMedicalM.font.pointSize withWidth:999999];
                self.lbOfMedicalM.frame = CGRectMake(CGRectGetMaxX(self.lbOfMedicalNumber.frame), self.lbOfMedical.frame.origin.y+2, boundslbOfMedicalM.size.width,boundslbOfMedicalM.size.height);
            }
            else{
            
//            CGFloat width = 20;
                CGFloat width = (6.0-[_model.bloodSugar doubleValue])*(80 /(7.8-3.9))/3*2;
                if (width > KLimit) {
                    width = KLimit;
                }

            self.lbOfMedical.frame = CGRectMake(CGRectGetMaxX(self.viewOfMedical.frame)-width, self.viewOfMedical.frame.origin.y+6, width, KRectangularH-12);
            self.lbOfMedical.backgroundColor = IWGreenColor;
            
            self.lbOfMedicalNumber.text = _model.bloodSugar;
            self.lbOfMedicalNumber.textColor = IWGreenColor;
            [self.lbOfMedicalNumber setFont:[UIFont systemFontOfSize:20]];
            CGRect boundslbOfMedicalNumber = [self.lbOfMedicalNumber.text getTextWidthAndHeightWithFont:self.lbOfMedicalNumber.font.pointSize withWidth:999999];
            self.lbOfMedicalNumber.frame = CGRectMake(CGRectGetMaxX(self.viewOfMedical.frame)+3, self.lbOfMedical.frame.origin.y-5, boundslbOfMedicalNumber.size.width, boundslbOfMedicalNumber.size.height);
            
            self.lbOfMedicalM.text = @"mmol/L";
            self.lbOfMedicalM.textColor = IWColor(150,150,150);
            [self.lbOfMedicalM setFont:[UIFont systemFontOfSize:12]];
            CGRect boundslbOfMedicalM = [self.lbOfMedicalM.text getTextWidthAndHeightWithFont:self.lbOfMedicalM.font.pointSize withWidth:999999];
            self.lbOfMedicalM.frame = CGRectMake(CGRectGetMaxX(self.lbOfMedicalNumber.frame), self.lbOfMedical.frame.origin.y+2, boundslbOfMedicalM.size.width, boundslbOfMedicalM.size.height);
            }

            
        }
                                                    
        else
        {
//            CGFloat width = 20;
            CGFloat width = (3.9-[_model.bloodSugar doubleValue])*(80 /(7.8-3.9))/3*2;
            if (width > KLimit) {
                width = KLimit;
            }

            
            self.lbOfMedical.frame = CGRectMake(CGRectGetMaxX(self.viewOfMedical.frame), self.viewOfMedical.frame.origin.y+6, width, KRectangularH-12);
            self.lbOfMedical.backgroundColor = IWColor(250,139,64);
            
            self.lbOfMedicalNumber.text = _model.bloodSugar;
            self.lbOfMedicalNumber.textColor = IWColor(216,0,67);
            [self.lbOfMedicalNumber setFont:[UIFont systemFontOfSize:20]];
            CGRect boundslbOfMedicalNumber = [self.lbOfMedicalNumber.text getTextWidthAndHeightWithFont:self.lbOfMedicalNumber.font.pointSize withWidth:999999];
            self.lbOfMedicalNumber.frame = CGRectMake(CGRectGetMaxX(self.lbOfMedical.frame)+3, self.lbOfMedical.frame.origin.y-5, boundslbOfMedicalNumber.size.width, boundslbOfMedicalNumber.size.height);
            
            self.lbOfMedicalM.text = @"mmol/L";
            self.lbOfMedicalM.textColor = IWColor(150,150,150);
            [self.lbOfMedicalM setFont:[UIFont systemFontOfSize:12]];
            CGRect boundslbOfMedicalM = [self.lbOfMedicalM.text getTextWidthAndHeightWithFont:self.lbOfMedicalM.font.pointSize withWidth:999999];
            self.lbOfMedicalM.frame = CGRectMake(CGRectGetMaxX(self.lbOfMedicalNumber.frame), self.lbOfMedical.frame.origin.y+2, boundslbOfMedicalM.size.width, boundslbOfMedicalM.size.height);
            
           
        }
    
    }
    
    if (_model.remark != nil && _model.remark.length>0) {
        self.lbOfRemark.hidden = NO;
        self.lbOfRemarkContent.hidden =NO;
        self.lbOfSeprateRemark.hidden = NO;
        self.lbOfSeprateRemark.frame = CGRectMake(0, CGRectGetMaxY(self.viewOfMedical.frame)+5, [UIScreen mainScreen].bounds.size.width, 0.8);
        self.lbOfSeprateRemark.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.lbOfRemark.text = @"备注:";
        self.lbOfRemark.textColor =IWColor(150,150,150);
        [self.lbOfRemark setFont:[UIFont systemFontOfSize:13]];
        CGRect boundslbOfRemark = [self.lbOfRemark.text getTextWidthAndHeightWithFont:self.lbOfRemark.font.pointSize withWidth:999999];
        self.lbOfRemark.frame = CGRectMake(15,CGRectGetMaxY(self.lbOfSeprateRemark.frame)+7 , boundslbOfRemark.size.width, boundslbOfRemark.size.height);
        
        self.lbOfRemarkContent.text = _model.remark;
        self.lbOfRemarkContent.textColor = IWColor(70,70,70);
        [self.lbOfRemarkContent setFont:[UIFont systemFontOfSize:13]];
        CGRect boundslbOfSeprateRemark = [self.lbOfRemarkContent.text getTextWidthAndHeightWithFont:self.lbOfRemarkContent.font.pointSize withWidth:999999];
        self.lbOfRemarkContent.frame = CGRectMake(CGRectGetMaxX(self.lbOfRemark.frame)+2, self.lbOfRemark.frame.origin.y,boundslbOfSeprateRemark.size.width , boundslbOfSeprateRemark.size.height);


        
    }
    else{
            self.lbOfRemark.hidden = YES;
        self.lbOfRemarkContent.hidden =YES;
        self.lbOfSeprateRemark.hidden = YES;
       
        
    }
}

- (void)setModel:(IWBloodSugerModel *)model
{
    _model = model;
}

@end
