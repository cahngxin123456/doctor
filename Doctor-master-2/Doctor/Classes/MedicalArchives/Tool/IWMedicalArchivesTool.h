//
//  IWMedicalArchivesTool.h
//  Doctor
//
//  Created by 范超 on 16/12/18.
//
//

#import <Foundation/Foundation.h>
#import "IWGetMedicalReportListParam.h"
#import "IWGetMedicalReportListResult.h"
#import "IWGetMedicalReportDetailParam.h"
#import "IWGetMedicalReportDetailResult.h"
#import "IWDeleteInquiryMemberParam.h"
#import "IWAddUserInfoParam.h"
#import "IWGetMedicalHealthDetailResult.h"
#import "IWGetMedicalHealthDetailParam.h"
#import "IWGetMedicalHealthDetailResult.h"
#import "IWDeleteMedicalReportParam.h"
#import "IWAddHeightParam.h"
#import "IWAddWeightParam.h"
#import "IWAddBloodparam.h"
#import "IWAddShengYuParam.h"
#import "IWAddYanJiuParam.h"
#import "IWAddGuoMinParam.h"
#import "IWAddBaoLuParam.h"
#import "IWAddOld1Param.h"
#import "IWAddOld2Param.h"
#import "IWAddOld3Param.h"
#import "IWAddJiaZuParam.h"
#import "IWAddYiChuanParam.h"
#import "IWAddCanjiParam.h"
#import "IWAddDuanLianParam.h"
#import "IWDeletePressureDetailParam.h"
#import "IWDeleteSugerDetailModel.h"
#import "IWAddReportParam.h"
#import "IWAddMedicalSugarParam.h"
#import "IWAddMedicalPressureParam.h"
#import "IWAddMedicalSugarResult.h"
#import "IWAddMedicalPressureResult.h"
#import "IWGetMedicalSugarListParam.h"
#import "IWGetMedicalSugarListResult.h"

@interface IWMedicalArchivesTool : NSObject


// 保存身高
+ (void)addMedicalHeightWithParam:(IWAddHeightParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存体重
+ (void)addMedicalWeightWithParam:(IWAddWeightParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存血型
+ (void)addMedicalBloodWithParam:(IWAddBloodparam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存生育
+ (void)addMedicalShengYuWithParam:(IWAddShengYuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存烟酒
+ (void)addMedicalYanJiuWithParam:(IWAddYanJiuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存过敏
+ (void)addMedicalGuoMinWithParam:(IWAddGuoMinParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存暴露
+ (void)addMedicalBaoLuWithParam:(IWAddBaoLuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存疾病
+ (void)addMedicalOld1WithParam:(IWAddOld1Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存手术
+ (void)addMedicalOld2WithParam:(IWAddOld2Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存输血
+ (void)addMedicalOld3WithParam:(IWAddOld3Param *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存家族
+ (void)addMedicalJiaZuWithParam:(IWAddJiaZuParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存遗传
+ (void)addMedicalYiChuanWithParam:(IWAddYiChuanParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存残疾
+ (void)addMedicalCanjiWithParam:(IWAddCanjiParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 保存锻炼
+ (void)addMedicalDuanLianWithParam:(IWAddDuanLianParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取医疗信息详情数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)medicalHealthDetailWithParam:(IWGetMedicalHealthDetailParam *)param success:(void (^)(IWGetMedicalHealthDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取病历报告列表
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)medicalReportListWithParam:(IWGetMedicalReportListParam *)param success:(void (^)(IWGetMedicalReportListResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取病历报告详情数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)medicalReportDetailWithParam:(IWGetMedicalReportDetailParam *)param success:(void (^)(IWGetMedicalReportDetailResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  提交个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 *  头像  NSData *headData = UIImageJPEGRepresentation(self.paImageView.image, 0.5);
 */
+ (void)submitUserInfoWithParams:(IWAddUserInfoParam *)param isMember:(BOOL)isMember datas:(NSData *)data success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  删除个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)deleteMedicalMemberWithParam:(IWDeleteInquiryMemberParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  删除病历报告
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)deleteMedicalReportWithParam:(IWDeleteMedicalReportParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;



//删除血压监测详情
+ (void)deletePressureDetailWithParam:(IWDeletePressureDetailParam *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;


//删除血糖详情
+ (void)deleteSugerDetailWithParam:(IWDeleteSugerDetailModel *)param success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  提交病历报告
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)submitReportWithParams:(IWAddReportParam *)param datas:(NSArray *)datas success:(void (^)(IWBaseResult *result))success failure:(void (^)(NSError *error))failure;

// 提交血压数据
+ (void)addMedicalPressureWithParam:(IWAddMedicalPressureParam *)param success:(void (^)(IWAddMedicalPressureResult *result))success failure:(void (^)(NSError *error))failure;


// 提交血糖数据
+ (void)addMedicalSugerWithParam:(IWAddMedicalSugarParam *)param success:(void (^)(IWAddMedicalSugarResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取血糖列表
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getMedicalSugarListListWithParam:(IWGetMedicalSugarListParam *)param success:(void (^)(IWGetMedicalSugarListResult *result))success failure:(void (^)(NSError *error))failure;

@end
