//
//  IWNnpViewCell.m
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import "IWNnpViewCell.h"
#import "IWNews.h"
#import "UIImageView+WebCache.h"

@interface IWNnpViewCell()
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;


@property (nonatomic, weak) UIView *divider;
@end

@implementation IWNnpViewCell

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
    static NSString *ID = @"notice";
    IWNnpViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWNnpViewCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (void)setNews:(IWNews *)news {
    _news = news;
    
    // 标题
    [self.labelTitle setText:news.title];
    
    // 类型
    NSString *category = @"";
    if ([news.category isEqualToString:@"notice"]) {
        category = NSLocalizedString(@"main_notification", nil);
    } else if ([news.category isEqualToString:@"policy"]) {
        category = NSLocalizedString(@"main_policy", nil);
    } else {
        category = NSLocalizedString(@"main_news", nil);
    }
    [self.labelCategory setText:category];
    
    // 时间
    [self.labelTime setText:news.insertTime];
    
    if (news.readStatus == 1) {
        // 已读
        [self.labelTitle setTextColor:[UIColor blackColor]];
    } else {
        // 未读
        [self.labelTitle setTextColor:[UIColor orangeColor]];
    }
}

@end
