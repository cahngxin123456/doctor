//
//  IMJIETagView.m
//  TDS
//
//  Created by admin on 16/4/13.
//  Copyright © 2016年 sixgui. All rights reserved.
//

#import "IMJIETagView.h"

@implementation IMJIETagView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
      
        selectedBtnList = [[NSMutableArray alloc] init];
        self.clickBackgroundColor = [UIColor whiteColor];
        self.clickTitleColor = TextColor;
        self.clickArray = nil;
        self.clickbool = YES;
        self.borderSize = 0.5;
        self.clickborderSize =0.5;
    }
    return self;
}

-(void)setTagsFrame:(IMJIETagFrame *)tagsFrame{

    _tagsFrame = tagsFrame;
    for (NSInteger i=0; i<tagsFrame.tagsArray.count; i++) {
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:tagsFrame.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:TextColor forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = TagTitleFont;
        tagsBtn.tag = i;
        tagsBtn.layer.masksToBounds = YES;
        tagsBtn.layer.cornerRadius = 0.5;
        

        // 加载图片
        UIImage *image = [UIImage imageNamed:@"xuanx_btn"];
        
        // 设置端盖的值
        CGFloat top = image.size.height * 0.5;
        CGFloat left = image.size.width * 0.5;
        CGFloat bottom = image.size.height * 0.5;
        CGFloat right = image.size.width * 0.5;
        
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
        
        // 拉伸图片
        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        
        // 设置按钮的背景图片
        [tagsBtn setBackgroundImage:newImage forState:UIControlStateNormal];
        [self makeCorner:self.borderSize view:tagsBtn color:UIColorRGBA(221, 221, 221, 1)];
        tagsBtn.frame = CGRectFromString(tagsFrame.tagsFrames[i]);
        [tagsBtn addTarget:self action:@selector(TagsBtn:) forControlEvents:UIControlEventTouchDown];
        tagsBtn.enabled = _clickbool;
        [self addSubview:tagsBtn];
    }

}

#pragma mark 选中背景颜色
-(void)setClickBackgroundColor:(UIColor *)clickBackgroundColor{

    if (_clickBackgroundColor != clickBackgroundColor) {
        _clickBackgroundColor = clickBackgroundColor;
    }
}

#pragma makr 选中字体颜色
-(void)setClickTitleColor:(UIColor *)clickTitleColor{

    if (_clickTitleColor != clickTitleColor) {
        _clickTitleColor = clickTitleColor;
    }
}

#pragma makr 能否被选中
-(void)setClickbool:(BOOL)clickbool{

    _clickbool = clickbool;
    
}

#pragma makr 未选中边框大小
-(void)setBorderSize:(CGFloat)borderSize{
    
    if (_borderSize!=borderSize) {
        _borderSize = borderSize;
    }
}

#pragma makr 选中边框大小
-(void)setClickborderSize:(CGFloat)clickborderSize{
    
    if (_clickborderSize!= clickborderSize) {
        _clickborderSize = clickborderSize;
    }
}

#pragma makr 默认选择 单选
-(void)setClickString:(NSString *)clickString{

    if (_clickString != clickString) {
        _clickString = clickString;
    }
    if ([_tagsFrame.tagsArray containsObject:_clickString]) {
        
        NSInteger index = [_tagsFrame.tagsArray indexOfObject:_clickString];
        [self ClickString:index];
    }
}

#pragma mark 默认选择 多选
-(void)setClickArray:(NSArray *)clickArray{

    if (_clickArray != clickArray) {
        _clickArray = clickArray;
    }
    
    for (NSString *string in clickArray) {
        
        if ([_tagsFrame.tagsArray containsObject:string]) {
            
            NSInteger index = [_tagsFrame.tagsArray indexOfObject:string];
            NSString *x = [[NSString alloc] initWithFormat:@"%ld",(long)index];
            [self ClickArray:x];
        }

    }
    
}

#pragma makr 单选
-(void)ClickString:(NSInteger )index{

    UIButton *btn;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)obj;
            if (btn.tag == index){
                
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 0.5;
                // 加载图片
                UIImage *image = [UIImage imageNamed:@"xuanx_btn_highlighted"];
                // 设置端盖的值
                CGFloat top = image.size.height * 0.5;
                CGFloat left = image.size.width * 0.5;
                CGFloat bottom = image.size.height * 0.5;
                CGFloat right = image.size.width * 0.5;
                
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
                
                // 拉伸图片
                UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
                
                // 设置按钮的背景图片
                [btn setBackgroundImage:newImage forState:UIControlStateNormal];
                
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

                [self makeCorner:_clickborderSize view:btn color:_clickTitleColor];
                [_delegate IMJIETagView:@[[NSString stringWithFormat:@"%ld",(long)index]]];
                
            }else{

                
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = 0.5;
                // 加载图片
                UIImage *image = [UIImage imageNamed:@"xuanx_btn"];
                
                // 设置端盖的值
                CGFloat top = image.size.height * 0.5;
                CGFloat left = image.size.width * 0.5;
                CGFloat bottom = image.size.height * 0.5;
                CGFloat right = image.size.width * 0.5;
                
                UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
                
                // 拉伸图片
                UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
                
                // 设置按钮的背景图片
                [btn setBackgroundImage:newImage forState:UIControlStateNormal];
//                [btn setTitleColor:TextColor forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

                [self makeCorner:_borderSize view:btn color:UIColorRGBA(221, 221, 221, 1)];
                
            }
        }
    }
}


#pragma mark 多选
-(void)ClickArray:(NSString *)index{

    UIButton *btn;
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            btn = (UIButton *)obj;
            if (btn.tag == [index integerValue]){
                
                if ([selectedBtnList containsObject:index]) {
                    btn.layer.masksToBounds = YES;
                    btn.layer.cornerRadius = 0.5;
                    // 加载图片
                    UIImage *image = [UIImage imageNamed:@"xuanx_btn"];
                    
                    // 设置端盖的值
                    CGFloat top = image.size.height * 0.5;
                    CGFloat left = image.size.width * 0.5;
                    CGFloat bottom = image.size.height * 0.5;
                    CGFloat right = image.size.width * 0.5;
                    
                    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
                    
                    // 拉伸图片
                    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
                    
                    // 设置按钮的背景图片
                    [btn setBackgroundImage:newImage forState:UIControlStateNormal];
                    //                [btn setTitleColor:TextColor forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                    [self makeCorner:_borderSize view:btn color:UIColorRGBA(221, 221, 221, 1)];
                    [selectedBtnList removeObject:index];
                    
                    
                }else{
                    
                    btn.layer.masksToBounds = YES;
                    btn.layer.cornerRadius = 0.5;
                    
                    // 加载图片
                    UIImage *image = [UIImage imageNamed:@"xuanx_btn_highlighted"];
                    
                    // 设置端盖的值
                    CGFloat top = image.size.height * 0.5;
                    CGFloat left = image.size.width * 0.5;
                    CGFloat bottom = image.size.height * 0.5;
                    CGFloat right = image.size.width * 0.5;
                    
                    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
                    
                    // 拉伸图片
                    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
                    
                    // 设置按钮的背景图片
                    [btn setBackgroundImage:newImage forState:UIControlStateNormal];
                    
                    //                [btn setTitleColor:_clickTitleColor forState:UIControlStateNormal];
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [self makeCorner:_clickborderSize view:btn color:_clickTitleColor];
                    [selectedBtnList addObject:index];
                    
                }
                
                [_delegate IMJIETagView:selectedBtnList];
            }
        }
    
    }
  
}

-(void)makeCorner:(CGFloat)corner view:(UIView *)view color:(UIColor *)color{
//    
//    CALayer * fileslayer = [view layer];
//    fileslayer.borderColor = [color CGColor];
//    fileslayer.borderWidth = corner;
//    
}

-(void)TagsBtn:(UIButton *)sender{

    if (self.clickStart == 0) {
    //单选
        [self ClickString:sender.tag];
        
    }else{
    //多选
        NSString *x = [[NSString alloc] initWithFormat:@"%ld",(long)sender.tag];
        [self ClickArray:x];
    }
}

@end
