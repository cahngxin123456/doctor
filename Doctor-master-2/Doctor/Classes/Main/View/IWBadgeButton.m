//
//  IWBadgeButton.m
//  Conedot
//
//  Created by 范超 on 14-9-23.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWBadgeButton.h"

@implementation IWBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithName:@"new_dot"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        // 设置文字
//        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
//        if (badgeValue.length > 1) {
//            // 文字的尺寸
//            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
//            badgeW = badgeSize.width + 10;
//        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
