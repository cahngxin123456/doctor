//
//  IWDepartmentCell.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWDepartmentCell.h"
#import "IWDepartment.h"

@interface IWDepartmentCell()
@property (nonatomic, weak) UIView *divider;

@end

@implementation IWDepartmentCell

/**
 *  在这个方法中设置子控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerX = 10;
    CGFloat dividerH = 0.5;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"department";
    IWDepartmentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWDepartmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.5;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)setDepartment:(IWDepartment *)department {
    _department = department;
    
    // name
    self.textLabel.text = department.deptName;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    // ass
     self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
