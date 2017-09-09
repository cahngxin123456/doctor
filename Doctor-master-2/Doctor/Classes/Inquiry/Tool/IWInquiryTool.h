//
//  IWInquiryTool.h
//  Doctor
//
//  Created by 范超 on 2016/12/24.
//
//

#import <Foundation/Foundation.h>
#import "IWGetInquiryParam.h"
#import "IWGetInquiryResult.h"
#import "IWAddInquiryParam.h"
#import "IWGetInquiryDetailParam.h"
#import "IWGetInquiryDetailResult.h"
#import "IWAddDoctorMessageParam.h"

@interface IWInquiryTool : NSObject

/**
 *  提交医生留言
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)submitDoctorMessageWithParams:(IWAddDoctorMessageParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取留言列表
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)inquiryListWithParam:(IWGetInquiryParam *)param success:(void (^)(IWGetInquiryResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  提交留言
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)submitInquiryWithParams:(IWAddInquiryParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;


/**
 *  获取留言详情数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)inquiryDetailWithParam:(IWGetInquiryDetailParam *)param success:(void (^)(IWGetInquiryDetailResult *result))success failure:(void (^)(NSError *error))failure;
//+ (void)inquiryDetailWithParam:(IWGetInquiryDetailParam *)param success:(void (^)(NSArray *resultArray))success failure:(void (^)(NSError *error))failure;

@end
