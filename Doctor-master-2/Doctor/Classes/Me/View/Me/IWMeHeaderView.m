//
//  IWMeHeaderView.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWMeHeaderView.h"
#import "IWUser.h"
#import "UIImageView+WebCache.h"
#import "PAImageView.h"

@interface IWMeHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, weak) PAImageView *avaterImageView;
@end

@implementation IWMeHeaderView

+ (instancetype)headerView {
    return [[NSBundle mainBundle] loadNibNamed:@"IWMeHeaderView" owner:nil options:nil][0];
}

- (void)awakeFromNib {
    // 添加PAImageView
    CGFloat imageSize = 46;
    PAImageView *avaterImageView = [[PAImageView alloc]initWithFrame:CGRectMake(10, 10, imageSize, imageSize) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor] placeholderImage:[UIImage imageWithName:@"head"]];
    [self.headerView addSubview:avaterImageView];
    self.avaterImageView = avaterImageView;
    UITapGestureRecognizer *avaterTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
    [avaterImageView addGestureRecognizer:avaterTap];
    
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
    [self.headerView addGestureRecognizer:viewTap];

}

- (void)iconClick:(UITapGestureRecognizer *)recongnizer {
    if ([self.delegate respondsToSelector:@selector(iconChange:)]) {
        [self.delegate iconChange:self.avaterImageView];
    }
}

- (void)viewClick:(UITapGestureRecognizer *)recongnizer {
    if ([self.delegate respondsToSelector:@selector(viewClick)]) {
        [self.delegate viewClick];
    }
}

- (void)setUser:(IWUser *)user {
    _user = user;
    
    self.nameLabel.text = user.userName;
    
    // 头像
    [self.avaterImageView setImageURL:user.photo];

    self.areaLabel.text = user.communityName;
}
@end
