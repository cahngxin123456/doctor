//
//  IWPhotosView.h
//  Conedot
//
//  Created by 范超 on 15/5/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWPhotosView : UIView
/**
 *  图片数据（里面都是HMPhoto模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

- (NSArray *)datas;

@property (nonatomic, assign) BOOL noClick;
@end
