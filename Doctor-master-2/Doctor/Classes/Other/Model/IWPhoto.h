//
//  IWPhoto.h
//  Conedot
//
//  Created by 范超 on 15/5/23.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface IWPhoto : NSObject
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign, getter=isShowDelete) BOOL showDelete;
@end
