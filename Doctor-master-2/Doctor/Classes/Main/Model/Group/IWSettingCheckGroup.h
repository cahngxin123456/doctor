//
//  IWSettingCheckGroup.h
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingGroup.h"
@class IWSettingCheckItem, IWSettingLabelItem;

@interface IWSettingCheckGroup : IWSettingGroup
/**
 *  选中的索引
 */
@property (assign, nonatomic) int checkedIndex;

/**
 *  选中的item
 */
@property (strong, nonatomic) IWSettingCheckItem *checkedItem;

/**
 *  来源于哪个item
 */
@property (strong, nonatomic) IWSettingLabelItem *sourceItem;
@end
