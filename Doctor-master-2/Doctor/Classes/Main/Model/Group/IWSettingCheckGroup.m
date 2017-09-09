//
//  IWSettingCheckGroup.m
//  Conedot
//
//  Created by 范超 on 14-10-12.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import "IWSettingCheckGroup.h"
#import "IWSettingCheckItem.h"
#import "IWSettingLabelItem.h"

@implementation IWSettingCheckGroup
- (IWSettingCheckItem *)checkedItem {
    for (IWSettingCheckItem *item in self.items) {
        if (item.isChecked) return item;
    }
    return nil;
}

- (void)setCheckedItem:(IWSettingCheckItem *)checkedItem {
    for (IWSettingCheckItem *item in self.items) {
        item.checked = (item == checkedItem);
    }
    self.sourceItem.text = checkedItem.title;
}

- (int)checkedIndex {
    for (int i = 0; i<self.items.count; i++) {
        IWSettingCheckItem *item = self.items[i];
        if (item.isChecked) return i;
    }
    return -1;
}

- (void)setCheckedIndex:(int)checkedIndex {
    if (checkedIndex <0 || checkedIndex >= self.items.count) return;
    
    self.checkedItem = self.items[checkedIndex];
}

- (void)setItems:(NSArray *)items {
    [super setItems:items];
    
    self.sourceItem = self.sourceItem;
}

- (void)setSourceItem:(IWSettingLabelItem *)sourceItem {
    _sourceItem = sourceItem;
    
    for (IWSettingCheckItem *item in self.items) {
        item.checked = [item.title isEqualToString:sourceItem.text];
    }
}
@end
