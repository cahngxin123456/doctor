//
//  IWContactGroup.h
//  Conedot
//
//  Created by 范超 on 15/3/8.
//  Copyright (c) 2015年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWContactGroup : NSObject
@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSMutableArray *items;

+ (instancetype)group;
@end
