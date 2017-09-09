//
//  IWAddReportFooterView.h
//  Doctor
//
//  Created by 深水区 on 16/12/28.
//
//

#import <UIKit/UIKit.h>
#import "IWPhotosView.h"
@interface IWAddReportFooterView : UIView

//@property (nonatomic, strong) <#ModelClass#> *model;

@property (nonatomic, weak) UITextView *textView;


@property (nonatomic, weak) UIButton *saveButton;

@property (nonatomic, weak) IWPhotosView *photosView;

@property (nonatomic, weak) UIView *addImageView;
@property (nonatomic, weak) UIButton *addImageButton;

@property (nonatomic, weak) UILabel *addImageText;
@property (nonatomic, weak) UIView *view2;


+ (instancetype)customViewWithFrame:(CGRect)frame;


@end
