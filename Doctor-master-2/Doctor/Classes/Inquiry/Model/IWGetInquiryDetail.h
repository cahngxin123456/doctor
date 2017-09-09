//
//  IWGetInquiryDetail.h
//  Doctor
//
//  Created by 范超 on 2017/1/8.
//
//

#import <Foundation/Foundation.h>

@interface IWGetInquiryDetail : NSObject
/**
 *  主键
 */
@property (nonatomic, copy) NSString *ID;

/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender;

/**
 *  生日
 */
@property (nonatomic, copy) NSString *birthday;

/**
 *  年龄
 */
@property (nonatomic, copy) NSString *age;

/**
 *  问题描述
 */
@property (nonatomic, copy) NSString *remark;

/**
 *  图片缩略图
 */
@property (nonatomic, copy) NSString *pictureThumb;

/**
 *  图片
 */
@property (nonatomic, copy) NSString *picture;


/**
 *  医生建议
 */
@property (nonatomic, copy) NSString *suggest;


/**
 *  医生建议的检查
 */
@property (nonatomic, copy) NSString *suggestCheck;

/**
 *  医生回复时间
 */
@property (nonatomic, copy) NSString *replyTime;

/**
 *  留言时间
 */
@property (nonatomic, copy) NSString *insertTime;

/**
 *  人员Id
 */
@property (nonatomic, copy) NSString *memberId;

/**
 *
 */
@property (nonatomic, copy) NSString *assessment;


@property (nonatomic, strong) NSArray *reportList;
@end
