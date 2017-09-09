//
//  IWInquiry.h
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>

@interface IWInquiry : NSObject

@property (nonatomic, copy) NSString *ID; // 主键
@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic, copy) NSString *gender; // 性别
@property (nonatomic, copy) NSString *age; // 年龄
@property (nonatomic, copy) NSString *overview; // 概述
@property (nonatomic, copy) NSString *picture; // 原图
@property (nonatomic, copy) NSString *pictureThumb; // 缩略图 (最多 6 张)
@property (nonatomic, copy) NSString *insertTime; // 发布时间
@property (nonatomic, assign) int inquiryType;
@property (nonatomic, copy) NSString *suggest;
@property (nonatomic, copy) NSString *suggestCheck;

@property (nonatomic, strong) NSArray *pictures;


@end
