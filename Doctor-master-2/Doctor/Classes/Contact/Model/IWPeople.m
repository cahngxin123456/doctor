//
//  IWPeople.m
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import "IWPeople.h"
#import "MJExtension.h"

@implementation IWPeople
- (NSArray *)phones {
    NSMutableArray *array = [NSMutableArray array];
    if (_cellphone != nil && ![_cellphone isEqualToString:@""]) {
        [array addObject:_cellphone];
    }
    
    if (_telephone1 != nil && ![_telephone1 isEqualToString:@""]) {
        [array addObject:_telephone1];
    }
    
    if (_telephone2 != nil && ![_telephone2 isEqualToString:@""]) {
        [array addObject:_telephone2];
    }
    
    if (_telephone3 != nil && ![_telephone3 isEqualToString:@""]) {
        [array addObject:_telephone3];
    }
    
    return array;
}

MJCodingImplementation
@end
