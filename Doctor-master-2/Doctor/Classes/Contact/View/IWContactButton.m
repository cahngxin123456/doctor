//
//  IWContactButton.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWContactButton.h"

#define IWButtonImageRatio 0.5

@implementation IWContactButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 文字颜色
        [self setTitleColor:IWColor(54, 109, 140) forState:UIControlStateNormal];
        [self setTitleColor:IWColor(54, 109, 140) forState:UIControlStateSelected];
    }
    return self;
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * IWButtonImageRatio;
    return CGRectMake(0, 10, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * IWButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

@end
