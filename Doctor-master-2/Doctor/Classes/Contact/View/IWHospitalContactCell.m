//
//  IWHospitalContactCell.m
//  Doctor
//
//  Created by 范超 on 2016/12/25.
//
//

#import "IWHospitalContactCell.h"
#import "IWHospitalContact.h"

@interface IWHospitalContactCell()

@property (nonatomic, weak) UIView *divider;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
- (IBAction)loadPhone:(id)sender;

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation IWHospitalContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
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
    static NSString *ID = @"hospitalcontact";
    IWHospitalContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWHospitalContactCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setContact:(IWHospitalContact *)contact {
    _contact = contact;
    
    self.labelName.text = contact.title;
    self.labelPhone.text = contact.number;
}

- (IBAction)loadPhone:(id)sender {
    [self dialPhone:self.contact.number];
}

// 拨打电话
- (void)dialPhone:(NSString *)phone {
    // 拨打电话
    NSString *real_phone = [NSString stringWithFormat:@"tel://%@", phone];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:real_phone]]];
}
@end
