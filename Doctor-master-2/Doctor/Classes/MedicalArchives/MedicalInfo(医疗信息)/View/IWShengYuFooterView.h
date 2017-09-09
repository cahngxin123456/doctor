//
//  IWShengYuFooterView.h
//  Doctor
//
//  Created by 深水区 on 16/12/26.
//
//

#import <UIKit/UIKit.h>

@interface IWShengYuFooterView : UIView

//@property (nonatomic, strong) <#ModelClass#> *model;


@property (nonatomic, weak) UIButton *deleteButton;
@property (nonatomic, copy) void(^deleteButtonBlock)();

@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, copy) void(^addButtonBlock)();

@property (nonatomic, weak) UIButton *saveButton;
@property (nonatomic, copy) void(^saveButtonBlock)();




+ (instancetype)customViewWithFrame:(CGRect)frame;

@end
