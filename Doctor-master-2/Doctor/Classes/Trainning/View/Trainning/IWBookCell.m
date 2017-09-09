//
//  IWBookCell.m
//  Conedot
//
//  Created by 范超 on 15/1/20.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWBookCell.h"
#import "IWBookItem.h"

@interface IWBookCell()
@property (nonatomic, weak) UIView *divider;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageDot;

@end

@implementation IWBookCell

- (void)awakeFromNib {
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor lightGrayColor];
    divider.alpha = 0.5;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

/**
 *  在这个方法中设置子控件的frame
 */
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
    static NSString *ID = @"book";
    IWBookCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"IWBookCell" owner:nil options:nil][0];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setBookItem:(IWBookItem *)bookItem {
    _bookItem = bookItem;
    
    self.nameLabel.text = bookItem.name;
    self.messageDot.hidden = (bookItem.unReadnum == 0);
    
    if (bookItem.isEnable) {
        self.nameLabel.textColor = IWColor(75, 75, 75);
        self.userInteractionEnabled = YES;
    } else {
        self.nameLabel.textColor = IWColor(155, 155, 155);
        self.userInteractionEnabled = NO;
    }
}

- (void)setLastRowInSection:(BOOL)lastRowInSection {
    _lastRowInSection = lastRowInSection;
    
    self.divider.hidden = lastRowInSection;
}

@end
