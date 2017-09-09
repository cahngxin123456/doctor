//
//  IWShengYuFooterView.m
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import "IWShengYuFooterView.h"

@implementation IWShengYuFooterView


+ (instancetype)customViewWithFrame:(CGRect)frame{
    IWShengYuFooterView *view = [[IWShengYuFooterView  alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor clearColor];
    view.userInteractionEnabled=YES;
    [view deleteButton];
    [view addButton];
    [view saveButton];
    return view;
}
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
-(void)updateConstraints{
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(-35);
        make.height.mas_equalTo(@(20));
        make.width.mas_equalTo(@(70));
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deleteButton.mas_bottom).offset(20);
        make.right.equalTo(self.saveButton.mas_right);
        make.height.mas_equalTo(@(30));
        make.width.mas_equalTo(@(30));
    }];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addButton.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(@(40));
    }];

    
    [super updateConstraints];
}
#pragma mark - 懒加载视图

-(UIButton *)deleteButton{
    if (_deleteButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(deletebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"删除" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button setTintColor:[UIColor orangeColor]];
        [button.layer setBorderWidth:1.5];
        button.titleLabel.font = IWFont;
        [button.layer setBorderColor:[UIColor orangeColor].CGColor];
        [self addSubview:button];
        _deleteButton=button;
    }
    return _deleteButton;
}

- (void)deletebuttonClicked:(UIButton *)btn{
    if (_deleteButtonBlock) {
        _deleteButtonBlock();
    }
}

-(UIButton *)addButton{
    if (_addButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor=[UIColor clearColor];
        [button addTarget:self action:@selector(addbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"add_btn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"add_btn_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:button];
        _addButton=button;
    }
    return _addButton;
}

- (void)addbuttonClicked:(UIButton *)btn{
    if (_addButtonBlock) {
        _addButtonBlock();
    }
    
    
}
-(UIButton *)saveButton{
    if (_saveButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(savebuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        
        NSArray *imageNameArray = @[@"t_btn_normal",@"t_btn_press"];
        for (int i = 0; i<2; i++) {
            // 加载图片
            UIImage *image = [UIImage imageNamed:imageNameArray[i]];
            // 设置端盖的值
            CGFloat top = image.size.height * 0.5;
            CGFloat left = image.size.width * 0.5;
            CGFloat bottom = image.size.height * 0.5;
            CGFloat right = image.size.width * 0.5;
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
            // 拉伸图片
            UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
            
            if (i == 0) {
                [button setBackgroundImage:newImage forState:UIControlStateNormal];
                
            }else
            {
                [button setBackgroundImage:newImage forState:UIControlStateHighlighted];
            }
        }
        [self addSubview:button];
        _saveButton = button;
        
    }
    return _saveButton;
}
- (void)savebuttonClicked:(UIButton *)btn{
    
    if (_saveButtonBlock) {
        _saveButtonBlock();
    }
    
}


#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}



@end
