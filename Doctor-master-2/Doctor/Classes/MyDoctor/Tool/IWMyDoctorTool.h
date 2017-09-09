//
//  IWMyDoctorTool.h
//  Doctor
//
//  Created by 范超 on 2017/1/5.
//
//

#import <Foundation/Foundation.h>
#import "IWMyDoctorParam.h"
#import "IWMyDoctorResult.h"

@interface IWMyDoctorTool : NSObject
/**
 *  加载混合列表数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)myDoctorWithParam:(IWMyDoctorParam *)param success:(void (^)(IWMyDoctorResult *result))success failure:(void (^)(NSError *error))failure;
@end
