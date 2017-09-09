//
//  IWBloodPressureHeaderView.h
//  Doctor
//
//  Created by 深水区 on 16/12/24.
//
//

#import <UIKit/UIKit.h>

@interface IWBloodPressureHeaderView : UIView

@property (nonatomic, weak) UILabel *firstLabel;
@property (nonatomic, weak) UILabel *secondLabel;
@property (nonatomic, weak) UILabel *thirdLabel;
+ (instancetype)customViewWithFrame:(CGRect)frame;
@end
