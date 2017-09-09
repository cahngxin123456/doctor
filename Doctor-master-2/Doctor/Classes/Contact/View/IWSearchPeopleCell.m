//
//  IWSearchPeopleCell.m
//  Conedot
//
//  Created by 范超 on 15/3/11.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWSearchPeopleCell.h"
#import "IWPeople.h"

#define IWSearchColor IWGlobalColor

@interface IWSearchPeopleCell()
@property (nonatomic, weak) UIView *divider;

@end

@implementation IWSearchPeopleCell

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
    static NSString *ID = @"people";
    IWSearchPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IWSearchPeopleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 线
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = [UIColor lightGrayColor];
        divider.alpha = 0.5;
        [self.contentView addSubview:divider];
        self.divider = divider;
    }
    return self;
}

- (void)setPeople:(IWPeople *)people{
    _people = people;
}

- (void)setQuery:(NSString *)query {
    // name
    self.textLabel.text = self.people.userName;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    // 详情
    
    NSString *subTitle = [NSString stringWithFormat:@"%@-%@", self.people.companyName, self.people.deptName];
    NSMutableAttributedString *ns = [[NSMutableAttributedString alloc] initWithString:subTitle];
    NSRange range = [[subTitle lowercaseString] rangeOfString:[query lowercaseString]];
    if (range.location != NSNotFound) {
        [ns addAttribute:NSForegroundColorAttributeName value:IWSearchColor range:range];
        self.detailTextLabel.attributedText = ns;
        self.textLabel.textColor = [UIColor blackColor];
    } else {
        self.detailTextLabel.text = subTitle;
        self.textLabel.textColor = IWSearchColor;
    }
}

@end
