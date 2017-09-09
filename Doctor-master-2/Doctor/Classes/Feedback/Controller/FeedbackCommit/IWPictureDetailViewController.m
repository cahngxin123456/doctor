//
//  IWPictureDetailViewController.m
//  Conedot
//
//  Created by 范超 on 15/4/13.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWPictureDetailViewController.h"

@interface IWPictureDetailViewController ()
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation IWPictureDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置基本内容
    [self setupBase];
    
    // 添加控件
    [self setupView];
}

/**
 *  添加控件
 */
- (void)setupView {
    // 添加ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加ImageView
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.path];
    imageView.image = image;
    CGFloat screenW = self.view.bounds.size.width;
    CGFloat screenH = self.view.bounds.size.height;
    CGFloat imageW = imageView.image.size.width; // 图片的宽度
    CGFloat imageH = imageView.image.size.height; // 图片的高度
    if (imageW > screenW) {
        imageW = screenW;
    }
    if (imageH > screenH) {
        imageH = screenH;
    }
    
    imageView.frame = CGRectMake(0, 0, imageW, imageH);
    [self.scrollView addSubview:imageView];
    
    // 设置Scrollview
    self.scrollView.contentSize = imageView.image.size;
}

/**
 *  设置基本内容
 */
- (void)setupBase {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"bit_picture", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteImage)];
}

- (void)deleteImage {
    if ([self.delegate respondsToSelector:@selector(deleteImageWithController:)]) {
        [self.delegate deleteImageWithController:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
