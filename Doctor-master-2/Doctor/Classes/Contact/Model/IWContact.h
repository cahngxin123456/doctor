//
//  IWContact.h
//  Conedot
//
//  Created by 范超 on 14-10-15.
//  Copyright (c) 2014年 范超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWContact : NSObject
@property (nonatomic, copy) NSString *value; // 姓名
@property (nonatomic, copy) NSString *type; // Department Or User
@property (nonatomic, copy) NSString *mail; // 邮件
@property (nonatomic, copy) NSString *cellphone; // 电话
@property (nonatomic, copy) NSString *telephone1; // 电话
@property (nonatomic, copy) NSString *telephone2; // 电话
@property (nonatomic, copy) NSString *telephone3; // 电话

@property (nonatomic, strong) NSArray *phones; // 所有有电话的集合

@property (nonatomic, assign) BOOL hasChildren; // 是否有子元素
@property (nonatomic, assign) BOOL isExpanded; // 是否展开
@property (nonatomic, assign) int level; // 在第几层
@property (nonatomic, copy) NSString *nodeId;  // id
@property (nonatomic, copy) NSString *parentId; // 父节点id

- (id)initWithDict:(NSDictionary *)dict;
+ (id)contactWithDict:(NSDictionary *)dict;

- (NSString *)showCellphone;

@end
