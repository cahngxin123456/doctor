//
//  IWTextView.m
//  Conedot
//
//  Created by 范超 on 15/3/11.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWTextView.h"

@interface IWTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation IWTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置边框
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [IWColor(209, 208, 203) CGColor];
        self.layer.borderWidth = 0.5;
        
        // 输入内容区域
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.textColor = IWColor(209, 208, 203);
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
        self.font = [UIFont systemFontOfSize:14];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange {
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self textDidChange];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    CGSize placeholderSize = [self.placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:maxSize];
    self.placeholderLabel.height = placeholderSize.height;
}

@end
