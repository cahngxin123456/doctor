//
//  IWSettingArrowItem.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingItem.h"

@class IWSettingArrowItem;

typedef void (^IWSettingArrowItemReadyForDestVc)(id item, id destVc);

@interface IWSettingArrowItem : IWSettingItem

@property (nonatomic, assign) Class destVcClass;
@property (nonatomic, copy) IWSettingArrowItemReadyForDestVc readyForDestVc;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
