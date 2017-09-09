//
//  IWMonitorAddDataHeaderView.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <UIKit/UIKit.h>

@interface IWMonitorAddDataHeaderView : UIView

//@property (nonatomic, strong) <#ModelClass#> *model;
@property (nonatomic, weak) UIButton *pressButton;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy)  void(^buttonBlock)(NSString *type);

+ (instancetype)customViewWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
