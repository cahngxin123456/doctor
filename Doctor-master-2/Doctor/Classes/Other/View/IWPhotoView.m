//
//  IWPhotoView.m
//  Conedot
//
//  Created by 范超 on 15/5/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWPhotoView.h"
#import "UIImageView+WebCache.h"
#import "IWPhoto.h"

@interface IWPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation IWPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
        // 添加删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageWithName:@"delete_normal"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageWithName:@"delete_press"] forState:UIControlStateHighlighted];
        deleteButton.width = 15;
        deleteButton.height = 15;
        [deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

- (void)delete {
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:IWImagesDeleteNotification object:self userInfo:@{IWImagesDeleteNotificationPic : self.photo.pic}];
}

- (void)setPhoto:(IWPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    if ([photo.pic hasPrefix:@"http"] || [photo.pic hasPrefix:@"https"]) {
        [self sd_setImageWithURL:[NSURL URLWithString:photo.pic] placeholderImage:[UIImage imageWithName:@"app_default_img"]];
    } else {
        [self setImage:[UIImage imageWithCGImage:photo.asset.thumbnail]];
    }
    
    // 2.控制gif图标的显示
    NSString *extension = photo.pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
    
    // 3. 是否显示deletebutton
    self.deleteButton.hidden = !photo.isShowDelete;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // gif
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
    // deletebutton
    self.deleteButton.x = self.width - self.deleteButton.width;
    self.deleteButton.y = 0;
}

@end
