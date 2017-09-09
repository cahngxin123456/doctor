//
//  IWPhotosView.m
//  Conedot
//
//  Created by 范超 on 15/5/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWPhotosView.h"
#import "UIImageView+WebCache.h"
#import "IWPhotoView.h"
#import "IWPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define IWPhotosMaxCount 6
#define IWPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define IWPhotoW 80
#define IWPhotoH IWPhotoW
#define IWPhotoMargin 10

@implementation IWPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 预先创建9个图片控件
        for (int i = 0; i< IWPhotosMaxCount; i++) {
            IWPhotoView *photoView = [[IWPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer {
    if (self.noClick) {
        return;
    }
    
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        IWPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    
    for (int i = 0; i<IWPhotosMaxCount; i++) {
        IWPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.pic_urls.count;
    int maxCols = IWPhotosMaxCols(count);
    for (int i = 0; i<count; i++) {
        IWPhotoView *photoView = self.subviews[i];
        photoView.width = IWPhotoW;
        photoView.height = IWPhotoH;
        photoView.x = (i % maxCols) * (IWPhotoW + IWPhotoMargin);
        photoView.y = (i / maxCols) * (IWPhotoH + IWPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    int maxCols = IWPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * IWPhotoW + (totalCols - 1) * IWPhotoMargin;
    CGFloat photosH = totalRows * IWPhotoH + (totalRows - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

- (NSArray *)datas {
    NSMutableArray *datas = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        IWPhotoView *photoView = self.subviews[i];
        NSString *url = photoView.photo.pic;
        if ([url hasPrefix:@"http"] || [url hasPrefix:@"https"]) {
            continue;
        }
        CGImageRef imageRef = photoView.photo.asset.defaultRepresentation.fullResolutionImage;
        NSData *data = UIImageJPEGRepresentation([[UIImage alloc] initWithCGImage:imageRef], 0.5);
        [datas addObject:data];
    }
    return datas;
}

@end
