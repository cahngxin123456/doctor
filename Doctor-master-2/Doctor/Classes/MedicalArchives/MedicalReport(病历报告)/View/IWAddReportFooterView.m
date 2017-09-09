//
//  IWAddReportFooterView.m
//  Doctor
//
//  Created by 深水区 on 16/12/28.
//
//

#import "IWAddReportFooterView.h"
#import "UzysAssetsPickerController.h"

@implementation IWAddReportFooterView


+ (instancetype)customViewWithFrame:(CGRect)frame{
    IWAddReportFooterView *view = [[IWAddReportFooterView  alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor whiteColor];
    view.userInteractionEnabled=YES;

    
    
    [view setuptextview];
    [view setupbuttonandlabel];
//    [view setupsaveButton];
    return view;
    
    
}

- (void)setuptextview{
    UITextView *textview = [[UITextView alloc] init];
    textview.frame = CGRectMake(10, 10, IWWIDTH - 20, 80);
    textview.backgroundColor=[UIColor whiteColor];
    textview.scrollEnabled = NO;
    textview.editable = YES;
    //        textview.delegate = self;
    textview.font=IWFont;
    textview.layer.masksToBounds = YES;
    textview.layer.borderWidth = 1;
    textview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textview.layer.cornerRadius = 2;
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.textColor = [UIColor blackColor];
    [self addSubview:textview];
    _textView = textview;
    
}

- (void)setupbuttonandlabel{

    // view2
    UIView *view2 = [[UIView alloc] init];
    view2.x = 10;
    view2.y = CGRectGetMaxY(self.textView.frame) + 10;
    view2.width = IWWIDTH - 20;
    view2.backgroundColor = [UIColor whiteColor];
    
    // photosView
    IWPhotosView *photosView = [[IWPhotosView alloc] init];
    photosView.noClick = true;
    [view2 addSubview:photosView];
    self.photosView = photosView;
    
    // addImageView
    UIView *addImageView = [[UIView alloc] init];
    addImageView.x = 10;
    addImageView.y = 20;
    addImageView.width = view2.width;
    addImageView.height = 50;
    self.addImageView = addImageView;
    [view2 addSubview:addImageView];
    
    
    UIButton *addImageButton = [[UIButton alloc] init];
    [addImageButton setImage:[UIImage imageWithName:@"photo_btn_normal"] forState:UIControlStateNormal];
    [addImageButton setImage:[UIImage imageWithName:@"photo_btn_press"] forState:UIControlStateHighlighted];
    addImageButton.x = 10;
    addImageButton.y = 10;
    addImageButton.width = 50;
    addImageButton.height = self.addImageView.height;
//    [addImageButton addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    [addImageButton setContentMode:UIViewContentModeCenter];
    [self.addImageView addSubview:addImageButton];
    self.addImageButton = addImageButton;
    
    UILabel *addImageText = [[UILabel alloc] init];
    addImageText.font = [UIFont systemFontOfSize:12];
    addImageText.textColor = [UIColor grayColor];
    addImageText.width = 200;
    addImageText.height = self.addImageView.height;
    addImageText.text = NSLocalizedString(@"flea_market_add_image", nil);
    addImageText.x = CGRectGetMaxX(self.addImageButton.frame) + 10;
    addImageText.y = 0;
    addImageText.contentMode = UIViewContentModeCenter;
    [self.addImageView addSubview:addImageText];
    self.addImageText = addImageText;
    
    view2.height = CGRectGetMaxY(addImageView.frame) + 10;
    [self addSubview:view2];
    self.view2 = view2;
    
}




#pragma mark -数据处理
//- (void)setModel:(<#ModelClass#> *)model
//{
//    _model = model;
//    [_imgView ideago_setImageWithURL:model.img placeholderImage:[UIImage imageNamed:@"placeholder1"]];
//    _titleLabel.text = model.title;
//}

@end
