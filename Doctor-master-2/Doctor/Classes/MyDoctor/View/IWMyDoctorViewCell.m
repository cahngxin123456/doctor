//
//  IWMyDoctorViewCell.m
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import "IWMyDoctorViewCell.h"
#import "IWMyDoctor.h"

@interface IWMyDoctorViewCell()
@property (nonatomic, weak) UIView *divider;
@property (weak, nonatomic) IBOutlet UIImageView *imageIcon;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelArea;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartment;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelGood;

@end

@implementation IWMyDoctorViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 0;
    CGFloat dividerH = 0.5;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"myDoctor";
    IWMyDoctorViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWMyDoctorViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setMyDoctor:(IWMyDoctor *)myDoctor {
    _myDoctor = myDoctor;
    
     [self.imageIcon sd_setImageWithURL:[NSURL URLWithString:myDoctor.photo] placeholderImage:[UIImage imageWithName:@"app_default_img"]];
    self.labelName.text = myDoctor.name;
    self.labelArea.text = myDoctor.doctorType;
    self.labelDepartment.text = myDoctor.department;
    self.labelTitle.text = myDoctor.title;
    self.labelGood.text = myDoctor.good;
}

@end
